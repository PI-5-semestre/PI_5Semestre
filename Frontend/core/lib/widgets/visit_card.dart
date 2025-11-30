import 'package:core/features/visits/data/models/visits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class VisitCard extends ConsumerWidget {
  final Visit visit;
  final String? appType;

  const VisitCard({super.key, required this.visit, this.appType = 'app'});

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
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final bool isMobile = constraints.maxWidth < 600;

                  if (isMobile) {
                    return Scaffold(
                      backgroundColor: Colors.black54,
                      body: SafeArea(
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius:
                                const BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          child: _VisitDetailsModal(
                            visit: visit,
                            address: address,
                            appType: appType,
                            isMobile: true,
                            onClose: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                    );
                  }

                  final maxWidth =
                      (constraints.maxWidth > 800 ? 800 : constraints.maxWidth * 0.95).toDouble();
                  final maxHeight =
                      (constraints.maxHeight > 650 ? 650 : constraints.maxHeight * 0.90).toDouble();

                  return Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: maxWidth,
                        maxHeight: maxHeight,
                      ),
                      child: Material(
                        elevation: 12,
                        borderRadius: BorderRadius.circular(16),
                        clipBehavior: Clip.hardEdge,
                        color: theme.colorScheme.surface,
                        child: _VisitDetailsModal(
                          visit: visit,
                          address: address,
                          appType: appType,
                          isMobile: false,
                          onClose: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },

        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
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
                      children: [
                        _buildChip(
                          visit.response?.roleStatus ?? 'Agendada',
                          _getStatusColor(),
                        ),
                        _buildChip(
                          visit.roleTypeVisit,
                          _getTypeVisitColor(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              if (visit.response == null ||
                  visit.response?.roleStatus == "Agendado")
                FloatingActionButton.small(
                  heroTag: "maps_${visit.id}",
                  onPressed: () => _openInGoogleMaps(address),
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
        color: color.withOpacity(0.15),
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
    final url = Uri.parse("https://www.google.com/maps/search/?api=1&query=$query");
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}

class _VisitDetailsModal extends StatelessWidget {
  final Visit visit;
  final String address;
  final String? appType;
  final bool isMobile;
  final VoidCallback onClose;

  const _VisitDetailsModal({
    required this.visit,
    required this.address,
    required this.appType,
    required this.isMobile,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final family = visit.family!;
    final theme = Theme.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Detalhes da Família',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: onClose,
              ),
            ],
          ),
        ),

        const Divider(height: 1),

        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Nome"),
                subtitle: Text(family.name),
              ),
              ListTile(
                leading: const Icon(Icons.phone),
                title: const Text("Telefone"),
                subtitle: Text(family.mobile_phone),
              ),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text("Endereço"),
                subtitle: Text(address),
              ),
              ListTile(
                leading: const Icon(Icons.group),
                title: const Text("Pessoas Autorizadas"),
                subtitle: Text(
                  (family.members?.isNotEmpty ?? false)
                      ? family.members!
                          .map((a) => "• ${a.name} (${a.roleKinship})")
                          .join("\n")
                      : "Nenhuma pessoa autorizada",
                ),
              ),
              ListTile(
                leading: const Icon(Icons.article),
                title: const Text("Observações"),
                subtitle: Text(visit.description ?? ''),
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                heroTag: "approve_${visit.id}",
                onPressed: () {},
                child: const Icon(Icons.check),
              ),

              FloatingActionButton(
                heroTag: "edit_${visit.id}",
                onPressed: () {
                  context.go(
                    appType == 'app'
                        ? '/more/visits/edit_visit'
                        : '/visits/edit_visit',
                    extra: visit,
                  );
                  onClose();
                },
                child: const Icon(Icons.edit),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
