import 'package:cestas_app/src/pages/delivery/new_delivery_page.dart';
import 'package:cestas_app/src/widgets/app_drawer.dart';
import 'package:core/services/state/delivery_provider.dart';
import 'package:core/widgets/card_header.dart';
import 'package:core/widgets/delivery_card.dart';
import 'package:core/widgets/statCard.dart';
import 'package:flutter/material.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DeliveryProvider>(context);
    final deliveries = provider.data ?? [];
    final counts = provider.counts.isNotEmpty
        ? provider.counts
        : {"Pendente": 0, "Entregue": 0, "Não Entregue": 0, "Total": 0};

    const statusOptions = ["Todos", "Pendente", "Entregue", "Não Entregue"];

    final filteredDeliveries = (deliveries ?? []).where((d) {
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
                _buildButton(context),
                const SizedBox(height: 16),
                _buildTodayLabel(),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _buildStatusCards(counts),
                ),
                const SizedBox(height: 16),
                _buildSearchField(),
                const SizedBox(height: 16),
                _buildStatusDropdown(statusOptions),
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
                              setState(() {}); // Atualiza cards e lista
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
    );
  }

  Widget _buildTodayLabel() {
    final now = DateTime.now();
    final today =
        "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}";
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.calendar_today, color: Colors.black54, size: 18),
          const SizedBox(width: 8),
          Text(
            "Entregas do dia $today",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
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
        icon: Icons.send,
        colors: [const Color(0xFF46B4FF), const Color(0xFF1075FA)],
        title: "Total",
        value: (safeCounts["Total"] ?? 0).toString(),
      ),
    ];
  }

  Widget _buildSearchField() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
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

  Widget _buildStatusDropdown(List<String> options) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: DropdownButtonFormField<String>(
          value: selectedStatus,
          items: options
              .map(
                (status) =>
                    DropdownMenuItem(value: status, child: Text(status)),
              )
              .toList(),
          onChanged: (value) {
            if (value != null) setState(() => selectedStatus = value);
          },
          decoration: const InputDecoration(border: InputBorder.none),
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

  Widget _buildButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const NewDeliveryPage()));
      },
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text(
        'Adicionar entregas',
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF155DFC),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
