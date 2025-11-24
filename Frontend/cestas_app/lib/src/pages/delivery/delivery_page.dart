import 'package:core/features/delivery/data/models/delivery.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:core/widgets/card_header.dart';
import 'package:core/widgets/delivery_card.dart';
import 'package:core/widgets/statCard.dart';
import 'package:core/widgets2/segmented_card_switcher.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeliveryPage extends ConsumerStatefulWidget {
  const DeliveryPage({super.key});

  @override
  ConsumerState<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends ConsumerState<DeliveryPage> {

  final List<DeliveryModel> deliveries = [
    DeliveryModel.fromJson({
      "id": "1",
      "active": true,
      "created": "2025-02-15T09:00:00Z",
      "institution_id": 1,
      "family_id": 10,
      "family": {
        "name": "João da Silva",
        "phone": "19 99999-0000",
        "address": "Rua A, Nº 123",
        "autorizados": [
          {
            "name": "Ana Silva",
            "parentesco": "Esposa"
          },
          {
            "name": "Patricia Silva",
            "parentesco": "Filha"
          }
        ]
      },
      "delivery_date": "2025-02-15T12:30:00Z",
      "account_id": 300,
      "status": "Pendente",
      "description": "Portão branco"
    }),
    DeliveryModel.fromJson({
      "id": "2",
      "active": true,
      "created": "2025-02-15T09:10:00Z",
      "institution_id": 1,
      "family_id": 11,
      "family": {
        "name": "Maria Souza",
        "phone": "19 98888-1111",
        "address": "Av. Paulista, 45",
        "autorizados": [
          {
            "name": "Carlos Souza",
            "parentesco": "Esposo"
          }
        ]
      },
      "delivery_date": "2025-02-15T12:35:00Z",
      "account_id": 300,
      "status": "Entregue",
      "description": "Tocar campainha"
    }),
    DeliveryModel.fromJson({
      "id": "3",
      "active": false,
      "created": "2025-02-15T09:20:00Z",
      "institution_id": 1,
      "family_id": 12,
      "family": {
        "name": "Carlos Santos",
        "phone": "19 97777-2222",
        "address": "Rua Central, 88",
        "autorizados": []
      },
      "delivery_date": "2025-02-15T13:00:00Z",
      "account_id": 300,
      "status": "Não Entregue",
      "description": "Casa azul"
    }),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final icons = [Icons.list_alt, Icons.access_time, Icons.check, Icons.close];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildCardHeader(),
                const SizedBox(height: 16),
                _buildTodayLabel(context, theme),
                const SizedBox(height: 16),
                _buildSearchField(),
                const SizedBox(height: 5),
                SegmentedCardSwitcher(
                  options: _buildStatusCards(deliveries),
                  icons: icons,
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildDeliveryHeader(theme),
            Column(
              children: deliveries.map((delivery) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: DeliveryCard(delivery: delivery),
                );
              }).toList(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/delivery/new_delivery'),
        child: const Icon(Icons.add),
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
  List<Widget> _buildStatusCards(List<DeliveryModel> deliveries) {
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
        value: deliveries.where((d) => d.status == "Pendente").length.toString(),
        backgroundColor: Colors.white,
      ),
      StatCard(
        icon: Icons.check,
        colors: [const Color(0xFF00C951), const Color(0xFF00A63E)],
        title: "Entregues",
        value: deliveries.where((d) => d.status == "Entregue").length.toString(),
      ),
      StatCard(
        icon: Icons.close,
        colors: [const Color(0xFFFF5C5C), const Color(0xFFB20000)],
        title: "Não Entregues",
        value: deliveries.where((d) => d.status == "Não Entregue").length.toString(),
      ),
    ];
  }

  Widget _buildSearchField() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: TextField(
          onChanged: (value) => {},
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
