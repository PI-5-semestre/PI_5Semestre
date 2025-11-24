import 'package:core/features/delivery/data/models/delivery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryCard extends ConsumerWidget {
  final DeliveryModel delivery;

  const DeliveryCard({
    super.key,
    required this.delivery,
  });

  Color _getStatusColor() {
    switch (delivery.status) {
      case "Entregue":
        return Color(0xFF016630);
      case "Pendente":
        return Colors.orange;
      case "Não Entregue":
        return Colors.red;
      default:
        return Colors.grey;
    }
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
                child: Center(
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
                                    'Detalhes da Família',
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
                                    leading: Icon(Icons.person),
                                    title: Text(
                                      'Nome',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: theme.colorScheme.outline,
                                      ),
                                    ),
                                    subtitle: Text(
                                      delivery.family.name,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.phone),
                                    title: Text(
                                      'Telefone',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: theme.colorScheme.outline,
                                      ),
                                    ),
                                    subtitle: Text(
                                      delivery.family.phone,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.location_on),
                                    title: Text(
                                      'Endereço',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: theme.colorScheme.outline,
                                      ),
                                    ),
                                    subtitle: Text(
                                      delivery.family.address,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.group),
                                    title: Text(
                                      'Pessoas Autorizadas',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: theme.colorScheme.outline,
                                      ),
                                    ),
                                    subtitle: Text(
                                      (delivery.family.autorizados?.isNotEmpty ?? false)
                                          ? delivery.family.autorizados!
                                              .map((a) => '- ${a.name} (${a.parentesco})')
                                              .join('\n')
                                          : 'Nenhuma pessoa autorizada',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.article),
                                    title: Text(
                                      'Observações',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: theme.colorScheme.outline,
                                      ),
                                    ),
                                    subtitle: Text(
                                      delivery.description ?? '',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 80),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Stack(
                        children: [
                          Positioned(
                            bottom: 16,
                            right: 16,
                            child: FloatingActionButton(
                              heroTag: "edit_${delivery.id}",
                              onPressed: () {
                                context.go(
                                  '/family/edit_family',
                                  extra: delivery,
                                );
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.edit),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // if (selected != null && onSelected != null)
              //   Checkbox(value: selected, onChanged: onSelected)
              // else
              //   const SizedBox.shrink(),
              // const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        delivery.family.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        alignment: WrapAlignment.start,
                        children: [
                          // _buildChip(recommended, _getBasketColor(recommended)),
                          _buildChip(delivery.status, _getStatusColor()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (delivery.status == "Pendente")
                FloatingActionButton.small(
                  heroTag: "delivery_${delivery.id}",
                  onPressed: () {
                    _openInGoogleMaps(delivery.family.address);
                  },
                  elevation: 1,
                  child: const Icon(Icons.send),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  void _openInGoogleMaps(String address) async {
    final query = Uri.encodeComponent(address);
    final url = Uri.parse(
      "https://www.google.com/maps/search/?api=1&query=$query",
    );

    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint("Não foi possível abrir o Google Maps: $e");
    }
  }
}
