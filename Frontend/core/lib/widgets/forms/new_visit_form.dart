import 'package:core/features/user/providers/user_provider.dart';
import 'package:core/features/visits/data/models/visits.dart';
import 'package:core/features/visits/providers/visit_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';
import 'package:flutter/material.dart';

class NewVisitForm extends ConsumerStatefulWidget {
  final int family_id;

  const NewVisitForm({required this.family_id, super.key});

  @override
  ConsumerState<NewVisitForm> createState() => NewVisitFormState();
}

class NewVisitFormState extends ConsumerState<NewVisitForm> {
  final formKey = GlobalKey<FormState>();

  final dateController = TextEditingController();
  final descController = TextEditingController();
  final selectController = TextEditingController();

  int? selectedAssistant;
  DateTime? selectedDateTime;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(userControllerProvider.notifier).fetchUsers();
    });
  }

  @override
  void dispose() {
    dateController.dispose();
    descController.dispose();
    selectController.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      initialDate: DateTime.now(),
    );

    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    selectedDateTime = dateTime;

    final formatted =
        "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year} "
        "${time.hour.toString().padLeft(2, '0')}:"
        "${time.minute.toString().padLeft(2, '0')}";

    setState(() {
      dateController.text = formatted;
    });
  }

  Future<void> _submitForm() async {
    if (!formKey.currentState!.validate()) return;

    if (selectedDateTime == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Selecione uma data válida.")),
      );
      return;
    }

    if (selectedAssistant == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Selecione o assistente.")));
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss");

      final Visit visit = Visit(
        account_id: selectedAssistant!,
        description: descController.text.trim(),
        type_of_visit: selectController.text.trim(),
        visit_at: formatter.format(selectedDateTime!),
      );

      await ref
          .read(visitControllerProvider.notifier)
          .createVisit(visit, widget.family_id);

      if (!mounted) return;

      final visitState = ref.read(visitControllerProvider);

      if (visitState.error != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(visitState.error!)));
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Visita agendada com sucesso!")),
      );

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao agendar visita: $e")));
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userControllerProvider);

    final assistants = userState.users
        .where((u) => u.account_type == "ASSISTANT")
        .toList();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Nova Visita",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              _buildSection(
                title: "Detalhes da Visita",
                icon: Icons.event,
                children: [
                  GestureDetector(
                    onTap: _pickDateTime,
                    child: AbsorbPointer(
                      child: _buildTextField(
                        "Data da visita",
                        controller: dateController,
                        validator: Validatorless.required("Informe a data"),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: DropdownButtonFormField<int>(
                      initialValue: selectedAssistant,
                      items: assistants.map((u) {
                        return DropdownMenuItem(
                          value: u.id,
                          child: Text(u.profile?.name ?? u.email),
                        );
                      }).toList(),
                      onChanged: userState.isLoading
                          ? null
                          : (v) => setState(() => selectedAssistant = v),
                      decoration: InputDecoration(
                        labelText: userState.isLoading
                            ? "Carregando assistentes..."
                            : "Assistente Social",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null) return "Selecione o assistente";
                        return null;
                      },
                    ),
                  ),

                  _buildTextField(
                    "Descrição",
                    controller: descController,
                    maxLines: 3,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: DropdownButtonFormField<String>(
                      initialValue: selectController.text.isEmpty
                          ? null
                          : selectController.text,
                      items: const [
                        DropdownMenuItem(
                          value: "ADMISSION",
                          child: Text("Admissão"),
                        ),
                        DropdownMenuItem(
                          value: "READMISSION",
                          child: Text("Readmissão"),
                        ),
                        DropdownMenuItem(
                          value: "ROUTINE",
                          child: Text("Rotina"),
                        ),
                      ],
                      decoration: InputDecoration(
                        labelText: "Tipo de Visita",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: Validatorless.required(
                        "Selecione o tipo de visita",
                      ),
                      onChanged: (v) {
                        if (v != null) {
                          selectController.text = v;
                        }
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _isSubmitting ? null : _submitForm,
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text("Salvar"),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  Widget _buildTextField(
    String label, {
    TextEditingController? controller,
    Function(String)? onChanged,
    String? Function(String?)? validator,
    bool readOnly = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        readOnly: readOnly,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
