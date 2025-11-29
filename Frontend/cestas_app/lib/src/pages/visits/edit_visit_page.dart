import 'package:core/features/visits/data/models/visits.dart';
import 'package:core/features/visits/providers/visit_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:validatorless/validatorless.dart';
import 'package:core/widgets/card_header.dart';
import 'package:flutter/material.dart';

class EditVisitPage extends ConsumerStatefulWidget {
  final Visit visit;
  const EditVisitPage({super.key, required this.visit});

  @override
  ConsumerState<EditVisitPage> createState() => _EditVisitPageState();
}

class _EditVisitPageState extends ConsumerState<EditVisitPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final visitationController = TextEditingController();
  final descriptionController = TextEditingController();
  final statusController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(visitControllerProvider.notifier).fetchVisits();
    });

    final v = widget.visit;

    nameController.text = v.family!.name;
    phoneController.text = v.family!.mobile_phone;
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    statusController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final visitState = ref.watch(visitControllerProvider);
    final controller = ref.watch(visitControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: ListView(
            children: [
              _buildCardHeader(),

              _buildSection(
                title: "Informações de Visitas",
                icon: Icons.person,
                children: [
                  _buildTextField(
                    "Nome *",
                    controller: nameController,
                    readOnly: true
                  ),
                  _buildTextField(
                    "Telefone",
                    controller: phoneController,
                    readOnly: true
                  ),
                  _buildTextField("Observações",
                    controller: descriptionController,
                    maxLines: 3,
                  ),
                  DropdownButtonFormField<String>(
                    initialValue: widget.visit.response?.status ?? 'PENDING',
                    items: const [
                      DropdownMenuItem(value: "ACCEPTED", child: Text("Aprovada")),
                      DropdownMenuItem(value: "REJECTED", child: Text("Reprovada")),
                      DropdownMenuItem(value: "PENDING", child: Text("Agendada")),
                    ],
                    onChanged: (v) {
                      setState(() {});
                      statusController.text = v ?? '';
                    },
                    validator: Validatorless.required("Selecione uma opção"),
                    decoration: InputDecoration(
                      labelText: "Situação",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: visitState.isLoading || statusController.text.trim() == "PENDING" ? null : () async {
          if (!_formKey.currentState!.validate()) return;

          final Response resp = Response(
            visitation_id: widget.visit.id,
            description: descriptionController.text.trim(),
            status: statusController.text.trim(),
          );

          await controller.createResponseVisit(resp);

          if (visitState.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(visitState.error!)),
            );
            return;
          }

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Visita atualizada com sucesso!")),
          );

          if (mounted) context.pop();
        },
        child: visitState.isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.check),
      ),
    );
  }

  // Reutilizável com validações
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

  Widget _buildCardHeader() => CardHeader(
    title: 'Atualizar Agendamento',
    subtitle: 'Atualiazar avaliação de famílias',
    colors: const [Color(0xFF2B7FFF), Color(0xFF155DFC)],
    icon: Icons.calendar_today,
  );

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Icon(icon, color: Colors.blue),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ]),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}
