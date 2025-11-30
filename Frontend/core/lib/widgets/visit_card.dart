import 'package:core/features/visits/data/models/visits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class VisitCard extends ConsumerWidget {
  final Visit visit;

  const VisitCard({super.key, required this.visit});

  Color _getStatusColor() {
    final status = visit.response?.roleStatus ?? "Agendada";

    switch (status) {
      case "Aprovada":
        return Colors.green;
      case "Agendada":
        return Colors.lightBlue;
      case "Reprovada":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getTypeVisitColor() {
    switch (visit.roleTypeVisit) {
      case "Admissão":
        return Colors.orange;
      case "Readmissão":
        return Colors.pink;
      case "Rotina":
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final family = visit.family!;
    final address =
        '${family.street}, n° ${family.number} - ${family.neighborhood}, ${family.city}/${family.state} - ${family.zip_code}';
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
                                      family.name,
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
                                      family.mobile_phone,
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
                                      address,
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
                                      (family.members?.isNotEmpty ?? false)
                                          ? family.members!
                                                .map(
                                                  (a) =>
                                                      '• ${a.name} (${a.roleKinship})',
                                                )
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
                                      visit.description ?? '',
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
                            left: 16,
                            child: FloatingActionButton(
                              heroTag: "visita_${visit.id}",
                              onPressed: () {},
                              child: const Icon(Icons.check),
                            ),
                          ),
                          Positioned(
                            bottom: 16,
                            right: 16,
                            child: FloatingActionButton(
                              heroTag: "edit_${visit.id}",
                              onPressed: () {
                                context.go(
                                  '/more/visits/edit_visit',
                                  extra: visit,
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
              Expanded(
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        family.name,
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
                          _buildChip(
                            visit.response?.roleStatus ?? 'Agendada',
                            _getStatusColor(),
                          ),
                          _buildChip(visit.roleTypeVisit, _getTypeVisitColor()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (visit.response == null || visit.response?.roleStatus == "Agendado")
                FloatingActionButton.small(
                  heroTag: "visita_${visit.id}",
                  onPressed: () {
                    _openInGoogleMaps(address);
                  },
                  elevation: 1,
                  child: const Icon(Icons.location_on),
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
