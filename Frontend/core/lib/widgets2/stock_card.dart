import 'package:core/features/stock/data/models/stock_model.dart';
import 'package:core/features/stock/providers/stock_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

class StockCardModal extends ConsumerWidget {
  final StockModel stock;

  const StockCardModal({super.key, required this.stock});

  Color _getStatusColor() {
    if (stock.quantity == 0) return Colors.red;
    if (stock.quantity != null && stock.quantity! <= 5) return Colors.orange;
    return Colors.green;
  }

  Future<void> _showEditQuantityDialog(
    BuildContext context,
    WidgetRef ref,
    StockModel stock,
  ) async {
    final quantityController = TextEditingController();
    String operation = "entrada";

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Movimentar estoque"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Tipo da operação:"),
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Expanded(
                        child: ChoiceChip(
                          label: const Text("Entrada"),
                          selected: operation == "entrada",
                          onSelected: (_) {
                            setState(() => operation = "entrada");
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ChoiceChip(
                          label: const Text("Saída"),
                          selected: operation == "saida",
                          onSelected: (_) {
                            setState(() => operation = "saida");
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Quantidade"),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancelar"),
                ),
                TextButton(
                  onPressed: () {
                    var qty = int.tryParse(quantityController.text);
                    if (qty == null || qty <= 0) return;

                    if (operation == "saida") {
                      qty = qty * -1;
                    }

                    ref
                        .read(stockControllerProvider.notifier)
                        .updateQuantity(stock.copyWith(quantity: qty));

                    Navigator.pop(context);
                  },
                  child: const Text("Salvar"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return Material(
                type: MaterialType.transparency,
                child: SizedBox(
                  height: 500,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Detalhes do Produto',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            Expanded(
                              child: ListView(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.inventory_2),
                                    title: _titleText('Nome'),
                                    subtitle: _valueText(stock.name ?? ''),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.qr_code),
                                    title: _titleText('SKU'),
                                    subtitle: _valueText(stock.sku ?? '-'),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.numbers),
                                    title: _titleText('Quantidade'),
                                    subtitle: _valueText(
                                      (stock.quantity ?? 0).toString(),
                                    ),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.calendar_today),
                                    title: _titleText('Criado em'),
                                    subtitle: _valueText(
                                      stock.created != null
                                          ? DateFormat(
                                              'dd/MM/yyyy',
                                            ).format(stock.created!)
                                          : '-',
                                    ),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.update),
                                    title: _titleText('Atualizado em'),
                                    subtitle: _valueText(
                                      stock.modified != null
                                          ? DateFormat(
                                              'dd/MM/yyyy',
                                            ).format(stock.modified!)
                                          : '-',
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Buttons (Delete + Edit)
                      Positioned(
                        bottom: 16,
                        left: 16,
                        child: Consumer(
                          builder: (context, ref, _) {
                            final isLoading = ref
                                .watch(stockControllerProvider)
                                .isLoading;

                            return FloatingActionButton(
                              heroTag: "delete_${stock.id}",
                              onPressed: isLoading
                                  ? null
                                  : () async {
                                      final confirm = await showDialog<bool>(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text(
                                              'Excluir Produto',
                                            ),
                                            content: Text(
                                              'Deseja excluir "${stock.name}" do estoque?',
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                  context,
                                                  false,
                                                ),
                                                child: const Text('Cancelar'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                  context,
                                                  true,
                                                ),
                                                child: const Text(
                                                  'Excluir',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      if (confirm != true) return;

                                      await ref
                                          .read(
                                            stockControllerProvider.notifier,
                                          )
                                          .delete(stock);

                                      final error = ref
                                          .read(stockControllerProvider)
                                          .error;

                                      if (error == null) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Produto excluído com sucesso!",
                                            ),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(content: Text(error)),
                                        );
                                      }

                                      Navigator.pop(context);
                                    },
                              backgroundColor:
                                  theme.colorScheme.surfaceContainerLow,
                              child: isLoading
                                  ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                      ),
                                    )
                                  : const Icon(Icons.delete),
                            );
                          },
                        ),
                      ),

                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: FloatingActionButton(
                          heroTag: "edit_${stock.id}",
                          onPressed: () {
                            context.go('/more/stock/edit', extra: stock);
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.edit),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: SizedBox(
          height: 80,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        stock.name ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        stock.sku ?? '-',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                _buildChip((stock.quantity ?? 0).toString(), _getStatusColor()),
                const SizedBox(width: 12),
                InkWell(
                  onTap: () {
                    _showEditQuantityDialog(context, ref, stock);
                  },
                  child: const Icon(Icons.inventory_outlined),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleText(String text) =>
      Text(text, style: const TextStyle(fontSize: 14, color: Colors.grey));

  Widget _valueText(String text) =>
      Text(text, style: const TextStyle(fontSize: 16));

  Widget _buildChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
