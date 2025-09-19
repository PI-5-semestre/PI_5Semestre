import 'package:cestas_app/widgets/app_drawer.dart';
import 'package:core/widgets/card_header.dart';
import 'package:core/widgets/delivery_card.dart';
import 'package:core/widgets/statCard.dart';
import 'package:flutter/material.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({super.key});

  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  String? selectedStatus;
  String searchQuery = "";

  late final List<DeliveryCard> allFamilies;

  @override
  void initState() {
    super.initState();
    allFamilies = [
      DeliveryCard(
        name: "Maria Silva",
        phone: "(11) 98765-4321",
        address: "Rua das Flores, 123 - São Paulo, SP",
        deliveryStatus: "Pendente",
        observations: "Idosa, prefere entrega pela manhã.",
      ),
      DeliveryCard(
        name: "João Pereira",
        phone: "(21) 98888-1111",
        address: "Av. Brasil, 450 - Rio de Janeiro, RJ",
        deliveryStatus: "Entregue",
        observations: "Entrega feita pelo vizinho.",
      ),
      DeliveryCard(
        name: "Ana Souza",
        phone: "(31) 97777-2222",
        address: "Rua Afonso Pena, 987 - Belo Horizonte, MG",
        deliveryStatus: "Não Entregue",
        observations: "Família ausente no horário agendado.",
      ),
      DeliveryCard(
        name: "Carlos Oliveira",
        phone: "(41) 96666-3333",
        address: "Rua XV de Novembro, 55 - Curitiba, PR",
        deliveryStatus: "Pendente",
        observations: "Possui 3 filhos pequenos.",
      ),
      DeliveryCard(
        name: "Fernanda Costa",
        phone: "(51) 95555-4444",
        address: "Av. Ipiranga, 800 - Porto Alegre, RS",
        deliveryStatus: "Entregue",
        observations: "Entrega realizada com sucesso.",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today =
        "${now.day.toString().padLeft(2, '0')}/"
        "${now.month.toString().padLeft(2, '0')}/"
        "${now.year}";

    final screenWidth = MediaQuery.of(context).size.width;
    final spacing = screenWidth < 600 ? 8.0 : 16.0;

    final cards = [
      StatCard(
        icon: Icons.access_time,
        colors: [Color(0xFFF0B100), Color(0xFFD08700)],
        title: "Pendentes",
        value: "2",
      ),
      StatCard(
        icon: Icons.check,
        colors: [Color(0xFF00C951), Color(0xFF00A63E)],
        title: "Entregues",
        value: "2",
      ),
      StatCard(
        icon: Icons.close,
        colors: [Color(0xFFFF5C5C), Color(0xFFB20000)],
        title: "Não Entregues",
        value: "1",
      ),
      StatCard(
        icon: Icons.send,
        colors: [Color(0xFF46B4FF), Color(0xFF1075FA)],
        title: "Total",
        value: "5",
      ),
    ];

    // aplica filtro de status e busca
    final filteredFamilies = allFamilies.where((f) {
      final matchesStatus = selectedStatus == null || selectedStatus == "Todos"
          ? true
          : f.deliveryStatus == selectedStatus;

      final lowerQuery = searchQuery.toLowerCase();
      final matchesSearch =
          f.name.toLowerCase().contains(lowerQuery) ||
          f.address.toLowerCase().contains(lowerQuery) ||
          f.observations.toLowerCase().contains(lowerQuery);

      return matchesStatus && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: ListView(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [_buildCardHeader(), const SizedBox(height: 16)],
                ),
                SizedBox(height: spacing),
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
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                      ),
                    ],
                  ),
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  alignment: WrapAlignment.spaceBetween,
                  runAlignment: WrapAlignment.spaceBetween,
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: cards,
                ),
                SizedBox(height: spacing),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        hintText: "Buscar família...",
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: spacing),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.filter_alt, color: Colors.black54),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedStatus,
                            hint: const Text("Filtrar por status"),
                            items: const [
                              DropdownMenuItem(
                                value: "Todos",
                                child: Text("Todos"),
                              ),
                              DropdownMenuItem(
                                value: "Pendente",
                                child: Text("Pendentes"),
                              ),
                              DropdownMenuItem(
                                value: "Entregue",
                                child: Text("Entregues"),
                              ),
                              DropdownMenuItem(
                                value: "Não Entregue",
                                child: Text("Não Entregues"),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedStatus = value;
                              });
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: spacing),
                Column(
                  children: filteredFamilies.map((family) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 4.0,
                      ),
                      child: SizedBox(width: double.infinity, child: family),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
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
}
