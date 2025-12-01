import 'package:core/features/shared_preferences/service/storage_service.dart';
import 'package:core/features/stock/data/models/stock_model.dart';
import 'package:core/features/stock/providers/stock_provider.dart';
import 'package:core/widgets/card_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditStockPage extends ConsumerStatefulWidget {
  final StockModel stock;
  const EditStockPage({super.key, required this.stock});

  @override
  ConsumerState<EditStockPage> createState() => _NewStockPageState();
}

class _NewStockPageState extends ConsumerState<EditStockPage> {
  final skuController = TextEditingController();
  final nameController = TextEditingController();
  final quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    skuController.text = widget.stock.sku ?? '';
    nameController.text = widget.stock.name ?? '';
  }

  @override
  void dispose() {
    skuController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(stockControllerProvider);
    final controller = ref.read(stockControllerProvider.notifier);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: ListView(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [_buildCardHeader()],
                ),
                _buildSection(
                  title: "Produtos",
                  icon: Icons.shopping_cart_checkout,
                  children: [
                    _buildTextField("SKU *", controller: skuController),
                    _buildTextField(
                      "Nome do produto *",
                      controller: nameController,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: state.isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Icon(Icons.check),
        onPressed: () async {
          if (!state.isLoading) {
            if (!_validateFields()) return;

            await ref
                .read(storageServiceProvider.notifier)
                .get<String>('institution_id');

            controller.update(
              widget.stock.copyWith(
                sku: skuController.text.trim(),
                name: nameController.text.trim(),
              ),
            );

            if (state.error == null) {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      "Produto atualizado!",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: theme.colorScheme.primary,
                  ),
                );
                Navigator.of(context).pop();
              }
            } else {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.error!,
                      style: TextStyle(color: theme.colorScheme.onError),
                    ),
                    backgroundColor: theme.colorScheme.error,
                  ),
                );
              }
            }
          }
        },
      ),
    );
  }

  Widget _buildCardHeader() {
    return CardHeader(
      title: 'Editar Produto',
      subtitle: 'Atualize os dados do produto',
      colors: const [Color(0xFF2B7FFF), Color(0xFF155DFC)],
      icon: Icons.shopping_bag,
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      color: Colors.white,
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: const Color(0xFF155DFC)),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        onChanged: onChanged,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  bool _validateFields() {
    if (skuController.text.trim().isEmpty ||
        nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Preencha todos os campos obrigatórios!",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
  }
}
