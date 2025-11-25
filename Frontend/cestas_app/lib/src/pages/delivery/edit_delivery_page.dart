import 'package:core/features/delivery/providers/delivery_provider.dart';
import 'package:core/features/delivery/data/models/delivery.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';
import 'package:core/widgets/card_header.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class EditDeliveryPage extends ConsumerStatefulWidget {
  final DeliveryModel delivery;
  const EditDeliveryPage({super.key, required this.delivery});

  @override
  ConsumerState<EditDeliveryPage> createState() => _EditDeliveryPageState();
}

class _EditDeliveryPageState extends ConsumerState<EditDeliveryPage> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final statusController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(deliveryControllerProvider.notifier).fetchDeliverys();
    });

    final d = widget.delivery;

    nameController.text = d.family!.name;
    statusController.text = d.status!;
    descriptionController.text = d.description ?? '';
  }

  @override
  void dispose() {
    nameController.dispose();
    statusController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deliveryState = ref.watch(deliveryControllerProvider);
    final controller = ref.watch(deliveryControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              _buildCardHeader(),

              _buildSection(
                title: "Informações Pessoais",
                icon: Icons.person,
                children: [
                  _buildTextField("Nome *",
                    controller: nameController,
                    validator: Validatorless.required("Campo obrigatório"),
                  ),
                  DropdownButtonFormField<String>(
                    initialValue: statusController.text.isNotEmpty
                        ? statusController.text
                        : widget.delivery.status,
                    items: const [
                      DropdownMenuItem(value: "COMPLETED", child: Text("Entregue")),
                      DropdownMenuItem(value: "PENDING", child: Text("Pendente")),
                      DropdownMenuItem(value: "CANCELED", child: Text("Não Entregue")),
                    ],
                    onChanged: (v) => statusController.text = v ?? '',
                    validator: Validatorless.required("Selecione uma opção"),
                    decoration: InputDecoration(
                      labelText: "Situação",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  _buildTextField("Observações",
                    controller: descriptionController,
                    maxLines: 3,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: deliveryState.isLoading ? null : () async {
          if (!formKey.currentState!.validate()) return;

          final Map<String, dynamic> updated = {  
            "id": widget.delivery.id,
            "date": getNextDeliveryDate(widget.delivery.delivery_date!, statusController.text.trim()),   
            "account_id": widget.delivery.account_id,   
            "description": descriptionController.text.trim(),
            "status": "PENDING"
          };

          await controller.updateDelivery(updated);

          if (ref.read(deliveryControllerProvider).error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(ref.read(deliveryControllerProvider).error!)),
            );
            return;
          }

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Entrega realizada com sucesso!")),
          );
          if (mounted) context.pop();
        },
        child: deliveryState.isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.check),
      ),
    );
  }

  Widget _buildCardHeader() {
    return CardHeader(
      title: 'Atualizar Entrega',
      subtitle: 'Atualize os dados de entrega da famílias',
      colors: const [Color(0xFF9810FA), Color(0xFFA223FC)],
      icon: FontAwesomeIcons.truck,
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
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

  String getNextDeliveryDate(DateTime currentDate, String status) {
    final formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss");

    DateTime newDate = currentDate;

    switch (status) {
      case "CANCELED":
        newDate = currentDate.add(const Duration(days: 1));
        break;

      case "COMPLETED":
        newDate = currentDate.add(const Duration(days: 30));
        break;

      case "PENDING":
      default:
        newDate = currentDate;
        break;
    }

    return formatter.format(newDate);
  }
}
