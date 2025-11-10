import 'package:flutter/material.dart';

class FamilyCard extends StatelessWidget {
  final String name;
  final String phone;
  final int members;
  final double income;
  final String cpf;
  final String address;
  final String observations;
  final String status; // ativo | pendente
  final String deliveryStatus; // recebendo | aguardando
  final String recommended; //Pequena | Media | Grande
  final bool? selected;
  final ValueChanged<bool?>? onSelected;

  const FamilyCard({
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
      case "Recomendado Pequena":
        return Colors.green;
      case "Recomendado Média":
        return Colors.orange;
      case "Recomendado Grande":
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return Material(
                type: MaterialType.transparency,
                child: Center(
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.8,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Detalhes da Família',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),

                            Expanded(
                              child: ListView(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.phone),
                                    title: const Text('Telefone'),
                                    subtitle: Text(phone),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.group),
                                    title: const Text('Membros'),
                                    subtitle: Text('$members pessoas'),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.attach_money),
                                    title: const Text('Renda'),
                                    subtitle: Text(
                                      'R\$ ${income.toStringAsFixed(2)}',
                                    ),
                                  ),
                                  ListTile(
                                    leading: const Icon(
                                      Icons.credit_card_rounded,
                                    ),
                                    title: const Text('CPF'),
                                    subtitle: Text(cpf),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.location_on),
                                    title: const Text('Endereço'),
                                    subtitle: Text(address),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.article),
                                    title: const Text('Observações'),
                                    subtitle: Text(observations),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.star),
                                    title: const Text('Recomendação'),
                                    subtitle: Text(recommended),
                                  ),
                                  const SizedBox(height: 80),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                        bottom: 16,
                        right: 16,
                        child: FloatingActionButton(
                          onPressed: () {
                            // Por enquanto não faz nada
                          },
                          child: const Icon(Icons.edit),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              if (selected != null && onSelected != null)
                Checkbox(value: selected, onChanged: onSelected)
              else
                const SizedBox.shrink(),
              const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
                  width: 300,
                  height: 100,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
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
                        alignment: WrapAlignment.start,
                        children: [
                          _buildChip(recommended, _getBasketColor(recommended)),
                          _buildChip(status, _getStatusColor(status)),
                          _buildChip(
                            deliveryStatus,
                            _getDeliveryColor(deliveryStatus),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (status == "pendente")
                FloatingActionButton.small(
                  onPressed: () {},
                  elevation: 1,
                  child: const Icon(Icons.calendar_today),
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
}
