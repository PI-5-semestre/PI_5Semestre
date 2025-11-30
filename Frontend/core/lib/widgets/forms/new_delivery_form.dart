import 'package:core/features/delivery/providers/delivery_provider.dart';
import 'package:core/features/user/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';
import 'package:flutter/material.dart';

class NewDeliveryForm extends ConsumerStatefulWidget {
  final int family_id;

  const NewDeliveryForm({required this.family_id, super.key});

  @override
  ConsumerState<NewDeliveryForm> createState() => NewDeliveryFormState();
}

class NewDeliveryFormState extends ConsumerState<NewDeliveryForm> {
  final formKey = GlobalKey<FormState>();

  final dateController = TextEditingController();
  final descController = TextEditingController();

  int? selectedDelivery;
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

    if (selectedDelivery == null) {
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

      final Map<String, dynamic> delivery = {   
        "family_id": widget.family_id,   
        "date": formatter.format(selectedDateTime!),   
        "account_id": selectedDelivery!,   
        "description": descController.text.trim() 
      };

      await ref
          .read(deliveryControllerProvider.notifier)
          .createDelivery(delivery);

      if (!mounted) return;

      final deliveryState = ref.read(deliveryControllerProvider);

      if (deliveryState.error != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(deliveryState.error!)));
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Entrega agendada com sucesso!")),
      );

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro ao agendar entrega: $e")));
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
        .where((u) => u.account_type == "DELIVERY_MAN")
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
                "Agendar Entrega",
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
                        "Data de entrega",
                        controller: dateController,
                        validator: Validatorless.required("Informe a data"),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: DropdownButtonFormField<int>(
                      initialValue: selectedDelivery,
                      items: assistants.map((u) {
                        return DropdownMenuItem(
                          value: u.id,
                          child: Text(u.profile?.name ?? u.email),
                        );
                      }).toList(),
                      onChanged: userState.isLoading
                          ? null
                          : (v) => setState(() => selectedDelivery = v),
                      decoration: InputDecoration(
                        labelText: userState.isLoading
                            ? "Carregando entregadores..."
                            : "Entregadores",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) {
                        if (value == null) return "Selecione o entregador";
                        return null;
                      },
                    ),
                  ),

                  _buildTextField(
                    "Descrição",
                    controller: descController,
                    maxLines: 3,
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
