import 'package:cesta_web/src/widgets/screen_size_widget.dart';
import 'package:core/features/delivery/providers/delivery_provider.dart';
import 'package:core/widgets2/skeleton/stat_card_skeleton.dart';
import 'package:core/widgets2/skeleton/team_card_skeleton.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:core/widgets/card_header.dart';
import 'package:core/widgets/delivery_card.dart';
import 'package:core/widgets/statCard.dart';
import 'package:core/widgets2/segmented_card_switcher.dart';
import 'package:flutter/material.dart';

class DeliveryPage extends ConsumerStatefulWidget {
  const DeliveryPage({super.key});

  @override
  ConsumerState<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends ConsumerState<DeliveryPage> {
  @override
  void initState() {
    super.initState(); 

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final deliveryState = ref.read(deliveryControllerProvider);
      if (deliveryState.deliveries.isEmpty && !deliveryState.isLoading) {
        ref.read(deliveryControllerProvider.notifier).fetchDeliverys();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final deliveryState = ref.watch(deliveryControllerProvider);
    final controller = ref.watch(deliveryControllerProvider.notifier);
    final theme = Theme.of(context);

    final icons = [Icons.list_alt, Icons.access_time, Icons.check];

    if (!deliveryState.isLoading && deliveryState.error != null && deliveryState.deliveries.isEmpty) {
      return Center(
        child: Text('Erro ao carregar entregas: ${deliveryState.error}'),
      );
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          controller.fetchDeliverys();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: ScreenSizeWidget(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildCardHeader(),
                    const SizedBox(height: 16),
                    _buildTodayLabel(context, theme),
                    const SizedBox(height: 16),
                    _buildSearchField(ref),
                    const SizedBox(height: 5),
                    if (deliveryState.isLoading)
                      Row(
                        children: [
                          Expanded(child: StatCardSkeleton())
                        ],
                      )
                    else
                      SegmentedCardSwitcher(
                        options: _buildStatusCards(deliveryState.deliveries),
                        icons: icons,
                        onTap: (index) {
                          switch (index) {
                            case 0:
                              controller.filterByRole(null);
                            case 1:
                              controller.filterByRole("PENDING");
                            case 2:
                              controller.filterByRole("COMPLETED");
                          }
                        },
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildDeliveryHeader(theme),
                if (deliveryState.isLoading)
                  Column(
                    children: List.generate(
                      4,
                      (_) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        child: Center(child: TeamCardSkeleton()),
                      )
                    ),
                  )
                else
                  Column(
                    children: deliveryState.filtered.map((delivery) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        child: DeliveryCard(delivery: delivery),
                      );
                    }).toList(),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTodayLabel(BuildContext context, ThemeData theme) {
    final now = DateTime.now().toUtc().subtract(const Duration(hours: 3));
    final formattedDate = DateFormat("EEEE | dd/MM/yyyy", "pt_BR").format(now);
    final capitalizedDate = formattedDate[0].toUpperCase() + formattedDate.substring(1);

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Ícone dentro do círculo
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.calendar_today,
                color: theme.colorScheme.primary,
                size: 30,
              ),
            ),
            const SizedBox(height: 16),

            // Texto principal
            const Text(
              "Entregas de Hoje",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            // Data
            Text(
              capitalizedDate,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6F6F6F),
              ),
            ),
          ],
        ),
      ),
    );
  }  

  List<Widget> _buildStatusCards(deliveries) {
    return [
      StatCard(
        icon: Icons.list_alt,
        colors: [const Color(0xFF46B4FF), const Color(0xFF1075FA)],
        title: "Total",
        value: deliveries.length.toString(),
      ),
      StatCard(
        icon: Icons.access_time,
        colors: [const Color(0xFFF0B100), const Color(0xFFD08700)],
        title: "Pendentes",
        value: deliveries.where((d) => d.deliveryStatus == "Pendente").length.toString(),
        backgroundColor: Colors.white,
      ),
      StatCard(
        icon: Icons.check,
        colors: [const Color(0xFF00C951), const Color(0xFF00A63E)],
        title: "Entregues",
        value: deliveries.where((d) => d.deliveryStatus == "Entregue").length.toString(),
      )
    ];
  }

  Widget _buildSearchField(WidgetRef ref) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: TextField(
          onChanged: (v) => ref.read(deliveryControllerProvider.notifier).search(v),
          decoration: const InputDecoration(
            hintText: "Nome, CPF, CEP ou Endereço...",
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildCardHeader() {
    return const CardHeader(
      title: 'Lista de entregas',
      subtitle: 'Confirme as entregas realizadas',
      colors: [Color(0xFF2B7FFF), Color(0xFF155DFC)],
      icon: Icons.check_box,
    );
  }

  Widget _buildDeliveryHeader(ThemeData theme) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          "Entregas",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.outline,
          ),
        ),
      ),
    );
  }
}
