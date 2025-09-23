import 'package:core/widgets/card_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cesta_web/src/views/delivery/new_delivery_page.dart';
import 'package:cesta_web/src/widgets/app_drawer.dart';
import 'package:core/services/state/delivery_provider.dart';
import 'package:core/widgets/card_header.dart';
import 'package:core/widgets/statCard.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryPage extends StatelessWidget {
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
  static const double _pagePadding = 16;
  static const double _spacing = 16;

  String selectedStatus = "Todos";
  String searchQuery = "";
  DateTime? selectedDate;

  String _formattedToday() {
    final now = DateTime.now();
    return "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}";
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DeliveryProvider>(context);
    final deliveries = provider.data ?? [];
    final counts = provider.counts.isNotEmpty
        ? provider.counts
        : {"Pendente": 0, "Entregue": 0, "Não Entregue": 0, "Total": 0};

    const statusOptions = ["Todos", "Pendente", "Entregue", "Não Entregue"];

    final filteredDeliveries = deliveries.where((d) {
      final matchesStatus =
          selectedStatus == "Todos" || d.status == selectedStatus;
      final matchesSearch = d.name.toLowerCase().contains(
        searchQuery.toLowerCase(),
      );
      final matchesDate =
          selectedDate == null ||
          (d.date.year == selectedDate!.year &&
              d.date.month == selectedDate!.month &&
              d.date.day == selectedDate!.day);
      return matchesStatus && matchesSearch && matchesDate;
    }).toList();

    return Scaffold(
      appBar: AppBar(),
      drawer: const AppDrawer(),
      body: provider.loading
          ? const Center(child: CircularProgressIndicator())
          : (provider.error != null && provider.error!.isNotEmpty)
          ? Center(child: Text(provider.error!))
          : ListView(
              padding: const EdgeInsets.all(_pagePadding),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                      child: CardHeader(
                        title: 'Lista de entregas',
                        subtitle: 'Confirme as entregas realizadas',
                        colors: [Color(0xFF9810FA), Color(0xFFA223FC)],
                        icon: Icons.check_box,
                      ),
                    ),
                    const SizedBox(width: _spacing),
                    _buildButton(context),
                  ],
                ),
                const SizedBox(height: _spacing),
                InfoCard(
                  title: "Entregas do dia ${_formattedToday()}",
                  color: const Color(0xFF9810FA),
                  icon: Icons.calendar_today,
                  iconColor: Colors.white,
                  iconBackground: Colors.white.withOpacity(0.2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStatCards(counts),
                      const SizedBox(height: _spacing),
                      Row(
                        children: [
                          Expanded(flex: 2, child: _buildSearchField()),
                          const SizedBox(width: _spacing),
                          Expanded(
                            flex: 1,
                            child: _buildStatusDropdown(statusOptions),
                          ),
                          const SizedBox(width: _spacing),
                          Expanded(flex: 1, child: _buildDatePicker(context)),
                        ],
                      ),
                      const SizedBox(height: _spacing),
                      _buildTable(filteredDeliveries),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildStatCards(Map<String, int> counts) {
    final cards = [
      StatCard(
        icon: Icons.access_time,
        colors: [const Color(0xFFF0B100), const Color(0xFFD08700)],
        title: "Pendentes",
        value: (counts["Pendente"] ?? 0).toString(),
      ),
      StatCard(
        icon: Icons.check,
        colors: [const Color(0xFF00C951), const Color(0xFF00A63E)],
        title: "Entregues",
        value: (counts["Entregue"] ?? 0).toString(),
      ),
      StatCard(
        icon: Icons.close,
        colors: [const Color(0xFFFF5C5C), const Color(0xFFB20000)],
        title: "Não Entregues",
        value: (counts["Não Entregue"] ?? 0).toString(),
      ),
      StatCard(
        icon: Icons.send,
        colors: [const Color(0xFF46B4FF), const Color(0xFF1075FA)],
        title: "Total",
        value: (counts["Total"] ?? 0).toString(),
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        final maxColumns = maxWidth > 1300
            ? 5
            : maxWidth > 1200
            ? 4
            : maxWidth > 800
            ? 3
            : maxWidth > 500
            ? 2
            : 1;

        final columns = cards.length < maxColumns ? cards.length : maxColumns;
        final totalSpacing = _spacing * (columns - 1);
        final cardWidth = (maxWidth - totalSpacing) / columns;

        return Wrap(
          spacing: _spacing,
          runSpacing: _spacing,
          children: cards
              .map((c) => SizedBox(width: cardWidth, child: c))
              .toList(),
        );
      },
    );
  }

  Widget _buildSearchField() {
    return TextField(
      onChanged: (value) => setState(() => searchQuery = value),
      decoration: InputDecoration(
        hintText: "Buscar família...",
        prefixIcon: const Icon(Icons.search),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildStatusDropdown(List<String> options) {
    return DropdownButtonFormField<String>(
      value: selectedStatus,
      items: options
          .map((status) => DropdownMenuItem(value: status, child: Text(status)))
          .toList(),
      onChanged: (value) {
        if (value != null) setState(() => selectedStatus = value);
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return InkWell(
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2100),
        );
        if (pickedDate != null) setState(() => selectedDate = pickedDate);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.date_range),
          hintText: "Filtrar por data",
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: Colors.white,
        ),
        child: Text(
          selectedDate == null
              ? "Selecionar data"
              : "${selectedDate!.day.toString().padLeft(2, '0')}/${selectedDate!.month.toString().padLeft(2, '0')}/${selectedDate!.year}",
        ),
      ),
    );
  }

  Widget _buildTable(List deliveries) {
    if (deliveries.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Text(
            "Nenhuma entrega encontrada",
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    final availableHeight =
        MediaQuery.of(context).size.height - kToolbarHeight - 350;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: availableHeight),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: constraints.maxWidth, // força a largura do InfoCard
              child: DataTable(
                columnSpacing: 24,
                headingRowColor: WidgetStateProperty.all(Colors.grey.shade200),
                dataRowMinHeight: 48,
                dataRowMaxHeight: 56,
                columns: const [
                  DataColumn(label: Text("Família")),
                  DataColumn(label: Text("Telefone")),
                  DataColumn(label: Text("Endereço")),
                  DataColumn(label: Text("Status")),
                  DataColumn(label: Text("Ações")),
                ],
                rows: deliveries.map((delivery) {
                  return DataRow(
                    cells: [
                      DataCell(Text(delivery.name)),
                      DataCell(Text(delivery.phone)),
                      DataCell(Text(delivery.address)),
                      DataCell(_buildStatusChip(delivery.status)),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.send,
                                color: Colors.blueAccent,
                              ),
                              onPressed: () =>
                                  _openInGoogleMaps(delivery.address),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.orange,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color textColor;
    Color bgColor;

    switch (status.toLowerCase()) {
      case "entregue":
        textColor = Colors.green.shade800;
        bgColor = const Color.fromARGB(50, 144, 254, 148);
        break;
      case "não entregue":
        textColor = Colors.red.shade800;
        bgColor = const Color.fromARGB(50, 236, 143, 137);
        break;
      default:
        textColor = Colors.orange.shade800;
        bgColor = const Color.fromARGB(50, 244, 244, 178);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: textColor),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: textColor,
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

  Widget _buildButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => NewDeliveryPage()));
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
