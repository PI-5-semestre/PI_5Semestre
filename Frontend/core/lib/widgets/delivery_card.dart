import 'package:core/features/delivery/data/models/delivery.dart';
import 'package:core/features/delivery/providers/delivery_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryCard extends ConsumerWidget {
  final DeliveryModel delivery;

  const DeliveryCard({super.key, required this.delivery});

  Color _getStatusColor() {
    switch (delivery.deliveryStatus) {
      case "Entregue":
        return const Color(0xFF016630);
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
    final family = delivery.family!;
    final theme = Theme.of(context);

    final address =
        '${family.street}, n° ${family.number} - ${family.neighborhood}, ${family.city}/${family.state} - ${family.zip_code}';

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
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20)),
                          ),
                          child: _DeliveryModal(
                            delivery: delivery,
                            address: address,
                            isMobile: true,
                            ref: ref,
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
                      constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
                      child: Material(
                        elevation: 12,
                        borderRadius: BorderRadius.circular(16),
                        clipBehavior: Clip.hardEdge,
                        color: theme.colorScheme.surface,
                        child: _DeliveryModal(
                          delivery: delivery,
                          address: address,
                          isMobile: false,
                          ref: ref,
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
                    _buildChip(delivery.deliveryStatus, _getStatusColor()),
                  ],
                ),
              ),

              if (delivery.deliveryStatus == "Pendente")
                FloatingActionButton.small(
                  heroTag: "delivery_${delivery.id}",
                  onPressed: () => _openInGoogleMaps(address),
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
    final url =
        Uri.parse("https://www.google.com/maps/search/?api=1&query=$query");
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}

class _DeliveryModal extends StatelessWidget {
  final DeliveryModel delivery;
  final String address;
  final bool isMobile;
  final WidgetRef ref;
  final VoidCallback onClose;

  const _DeliveryModal({
    required this.delivery,
    required this.address,
    required this.isMobile,
    required this.ref,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final family = delivery.family!;
    final theme = Theme.of(context);

    final deliveryState = ref.watch(deliveryControllerProvider);
    final controller = ref.watch(deliveryControllerProvider.notifier);

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
                title: const Text('Nome'),
                subtitle: Text(family.name),
              ),
              ListTile(
                leading: const Icon(Icons.phone),
                title: const Text('Telefone'),
                subtitle: Text(family.mobile_phone),
              ),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text('Endereço'),
                subtitle: Text(address),
              ),
              ListTile(
                leading: const Icon(Icons.group),
                title: const Text('Pessoas Autorizadas'),
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
                title: const Text('Observações'),
                subtitle: Text(delivery.description ?? ''),
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
                heroTag: "mark_${delivery.id}",
                backgroundColor: theme.colorScheme.surfaceContainerLow,
                onPressed: deliveryState.isLoading
                    ? null
                    : () async {
                        final formatter =
                            DateFormat("yyyy-MM-dd'T'HH:mm:ss");

                        final Map<String, dynamic> updated = {
                          "id": delivery.id,
                          "date": formatter.format(delivery.delivery_date!),
                          "account_id": delivery.account_id,
                          "description": delivery.description,
                          "status": "COMPLETED",
                        };

                        await controller.updateDelivery(updated);

                        final error =
                            ref.read(deliveryControllerProvider).error;

                        if (error != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(error)),
                          );
                          return;
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Entrega atualizada com sucesso!")),
                        );

                        onClose();
                      },
                child: deliveryState.isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 3),
                      )
                    : const Icon(Icons.check),
              ),

              FloatingActionButton(
                heroTag: "edit_${delivery.id}",
                onPressed: () {
                  context.go('/delivery/edit_delivery', extra: delivery);
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
