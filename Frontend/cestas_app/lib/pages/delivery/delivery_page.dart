import 'package:cestas_app/pages/delivery/new_delivery_page.dart';
import 'package:cestas_app/pages/delivery/state/delivery_provider.dart';
import 'package:cestas_app/widgets/app_drawer.dart';
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
      create: (_) => DeliveryProvider(),
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
    final now = DateTime.now();
    final today =
        "${now.day.toString().padLeft(2, '0')}/"
        "${now.month.toString().padLeft(2, '0')}/"
        "${now.year}";
    final provider = Provider.of<DeliveryProvider>(context);
    final counts = provider.counts;

    const statusOptions = ["Todos", "Pendente", "Entregue", "Não Entregue"];

    final statusCards = [
      StatCard(
        icon: Icons.access_time,
        colors: [Color(0xFFF0B100), Color(0xFFD08700)],
        title: "Pendentes",
        value: counts["Pendente"].toString(),
      ),
      StatCard(
        icon: Icons.check,
        colors: [Color(0xFF00C951), Color(0xFF00A63E)],
        title: "Entregues",
        value: counts["Entregue"].toString(),
      ),
      StatCard(
        icon: Icons.close,
        colors: [Color(0xFFFF5C5C), Color(0xFFB20000)],
        title: "Não Entregues",
        value: counts["Não Entregue"].toString(),
      ),
      StatCard(
        icon: Icons.send,
        colors: [Color(0xFF46B4FF), Color(0xFF1075FA)],
        title: "Total",
        value: counts["Total"].toString(),
      ),
    ];

    final filteredDeliveries = provider.deliveries.where((d) {
      final matchesStatus = selectedStatus == "Todos"
          ? true
          : d.status == selectedStatus;
      final matchesSearch = d.name.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      return matchesStatus && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(),
      drawer: const AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCardHeader(),
          const SizedBox(height: 16),
          _buildButton(context),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  color: Colors.black54,
                  size: 18,
                ),
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
          ),
          const SizedBox(height: 16),
          Wrap(spacing: 8, runSpacing: 8, children: statusCards),
          const SizedBox(height: 16),
          Card(
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
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: DropdownButtonFormField<String>(
                value: selectedStatus,
                items: statusOptions
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
          ),
          const SizedBox(height: 16),
          Column(
            children: filteredDeliveries.map((delivery) {
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
          ),
        ],
      ),
    );
  }

  Widget _buildCardHeader() {
    return CardHeader(
      title: 'Lista de entregas',
      subtitle: 'Confirme as entregas realizadas',
      colors: [Color(0xFF9810FA), Color(0xFFA223FC)],
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
        backgroundColor: const Color(0xFF9810FA),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
