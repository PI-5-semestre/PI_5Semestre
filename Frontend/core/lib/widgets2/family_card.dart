import 'package:flutter/material.dart';

class FamilyCardModal extends StatelessWidget {
  final String name;
  final String phone;
  final int members;
  final double income;
  final String cpf;
  final String address;
  final String observations;
  final String status; // ativo | pendente
  final String deliveryStatus; // recebendo | aguardando
  final String recommended;
  final bool? selected;
  final ValueChanged<bool?>? onSelected;

  const FamilyCardModal({
    super.key,
    required this.name,
    required this.phone,
    required this.members,
    required this.income,
    required this.cpf,
    required this.address,
    required this.observations,
    required this.status,
    required this.deliveryStatus,
    required this.recommended,
    this.selected,
    this.onSelected,
  });

  Color _getStatusColor(String status) {
    switch (status) {
      case "ativa":
        return Color(0xFF016630);
      case "pendente":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Color _getDeliveryColor(String status) {
    switch (status) {
      case "recebendo":
        return Color(0xFF193CB8);
      case "aguardando":
        return Color(0xFF6E11B0);
      default:
        return Colors.grey;
    }
  }

  Color _getBasketColor(String recommended) {
    switch (recommended) {
      case "Pequena":
        return Colors.green;
      case "Média":
        return Colors.orange;
      case "Grande":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true, // permite altura maior
            backgroundColor: Colors.transparent, // se quiser transparente
            builder: (BuildContext context) {
              return SizedBox(
                height: 500,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                      ),
                      child: Column(
                        children: [
                          // Cabeçalho
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Detalhes da Família',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          // Lista rolável
                          Expanded(
                            child: ListView(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                              children: [
                                ListTile(
                                  leading: Icon(Icons.phone),
                                  title: Text(
                                    'Telefone',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: theme.colorScheme.outline,
                                    ),
                                  ),
                                  subtitle: Text(
                                    phone,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(Icons.group),
                                  title: Text(
                                    'Membros',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: theme.colorScheme.outline,
                                    ),
                                  ),
                                  subtitle: Text(
                                    members.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(Icons.attach_money),
                                  title: Text(
                                    'Renda',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: theme.colorScheme.outline,
                                    ),
                                  ),
                                  subtitle: Text(
                                    income.toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(Icons.credit_card_rounded),
                                  title: Text(
                                    'CPF',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: theme.colorScheme.outline,
                                    ),
                                  ),
                                  subtitle: Text(
                                    cpf,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(Icons.location_on),
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
                                  leading: Icon(Icons.article),
                                  title: Text(
                                    'Observações',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: theme.colorScheme.outline,
                                    ),
                                  ),
                                  subtitle: Text(
                                    observations,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(Icons.star),
                                  title: Text(
                                    'Recomendação',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: theme.colorScheme.outline,
                                    ),
                                  ),
                                  subtitle: Text(
                                    recommended,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: theme.colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                                // ... demais ListTiles
                                SizedBox(height: 10), // dá espaço para o FAB
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // FloatingActionButton fixo
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: FloatingActionButton(
                        onPressed: () {},
                        child: Icon(Icons.edit),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: SizedBox(
          width: 300,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  child: Icon(Icons.person, size: 25),
                ),
                title: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Wrap(
                  spacing: 6,
                  runSpacing: -6,
                  children: [
                    _buildChip(status, _getStatusColor(status)),
                    _buildChip(
                      deliveryStatus,
                      _getDeliveryColor(deliveryStatus),
                    ),
                  ],
                ),
                trailing: status == "pendente"
                    ? FloatingActionButton.small(
                        onPressed: () {},
                        elevation: 1,
                        child: const Icon(Icons.calendar_today),
                      )
                    : null,
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
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
