import 'package:intl/intl.dart';
import 'package:core/services/state/delivery_provider.dart';
import 'package:core/widgets/card_header.dart';
import 'package:core/widgets/delivery_card.dart';
import 'package:core/widgets/statCard.dart';
import 'package:core/widgets2/segmented_card_switcher.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DeliveryPage extends StatelessWidget {
  const DeliveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final provider = DeliveryProvider();
        provider.fetchDeliveries();
        return provider;
      },
      child: const _DeliveryView(),
    );
  }
}

class _DeliveryView extends StatefulWidget {
  const _DeliveryView({super.key});

  @override
  State<_DeliveryView> createState() => _DeliveryViewState();
}

class _DeliveryViewState extends State<_DeliveryView> {
  String selectedStatus = "Todos";
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DeliveryProvider>(context);
    final deliveries = provider.data ?? [];
    final counts = provider.counts.isNotEmpty
        ? provider.counts
        : {"Pendente": 0, "Entregue": 0, "Não Entregue": 0, "Total": 0};

    final icons = [Icons.access_time, Icons.check, Icons.close, Icons.list_alt];

    final filteredDeliveries = deliveries.where((d) {
      final matchesStatus = selectedStatus == "Todos"
          ? true
          : d.status == selectedStatus;
      final matchesSearch = d.name.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      return matchesStatus && matchesSearch;
    }).toList();

    return Scaffold(
      body: provider.loading
          ? const Center(child: CircularProgressIndicator())
          : (provider.error != null && provider.error!.isNotEmpty)
          ? Center(child: Text(provider.error!))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildCardHeader(),
                const SizedBox(height: 16),
                _buildSearchField(),
                const SizedBox(height: 16),
                _buildTodayLabel(context),
                const SizedBox(height: 16),
                SegmentedCardSwitcher(
                  options: _buildStatusCards(counts),
                  icons: icons,
                ),
                const SizedBox(height: 16),
                filteredDeliveries.isNotEmpty
                    ? Column(
                        children: filteredDeliveries.map<Widget>((delivery) {
                          return DeliveryCard(
                            name: delivery.name,
                            phone: delivery.phone,
                            address: delivery.address,
                            observations: delivery.observations,
                            deliveryStatus: delivery.status,
                            onStatusChanged: (newStatus) {
                              provider.updateStatusObject(delivery, newStatus);
                              setState(() {});
                            },
                          );
                        }).toList(),
                      )
                    : const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32),
                          child: Text(
                            "Nenhuma entrega encontrada",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/delivery/new_delivery');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTodayLabel(BuildContext context) {
    final now = DateTime.now().toUtc().subtract(const Duration(hours: 3));
    final formattedDate = DateFormat("EEEE, dd/MM/yyyy", "pt_BR").format(now);
    final capitalizedDate =
        formattedDate[0].toUpperCase() + formattedDate.substring(1);

    return Card(
      elevation: 0,
      color: const Color(0xFFF8FAFF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today,
              color: Color(0xFF2B7FFF),
              size: 22,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                "Entregas de hoje • $capitalizedDate",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildStatusCards(Map<String, int>? counts) {
    final safeCounts =
        counts ?? {"Pendente": 0, "Entregue": 0, "Não Entregue": 0, "Total": 0};

    return [
      StatCard(
        icon: Icons.access_time,
        colors: [const Color(0xFFF0B100), const Color(0xFFD08700)],
        title: "Pendentes",
        value: (safeCounts["Pendente"] ?? 0).toString(),
        backgroundColor: Colors.white,
      ),
      StatCard(
        icon: Icons.check,
        colors: [const Color(0xFF00C951), const Color(0xFF00A63E)],
        title: "Entregues",
        value: (safeCounts["Entregue"] ?? 0).toString(),
      ),
      StatCard(
        icon: Icons.close,
        colors: [const Color(0xFFFF5C5C), const Color(0xFFB20000)],
        title: "Não Entregues",
        value: (safeCounts["Não Entregue"] ?? 0).toString(),
      ),
      StatCard(
        icon: Icons.list_alt,
        colors: [const Color(0xFF46B4FF), const Color(0xFF1075FA)],
        title: "Total",
        value: (safeCounts["Total"] ?? 0).toString(),
      ),
    ];
  }

  Widget _buildSearchField() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: TextField(
          onChanged: (value) => setState(() => searchQuery = value),
          decoration: const InputDecoration(
            hintText: "Buscar família...",
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
}
