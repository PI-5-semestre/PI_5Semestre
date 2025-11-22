import 'package:core/features/family/data/models/family_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FamilyCard extends ConsumerWidget {
  final FamilyModel family;

  const FamilyCard({
    super.key,
    required this.family,
  });

  Color _getStatusColor() {
    switch (family.roleSituation) {
      case "Ativa":
        return Color(0xFF016630);
      case "Pendente":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Color _getDeliveryColor() {
    switch (family.deliveryStatus) {
      case "Recebendo":
        return Color(0xFF193CB8);
      case "Aguardando":
        return Color(0xFF6E11B0);
      default:
        return Colors.grey;
    }
  }

  // Color _getBasketColor(String recommended) {
  //   switch (recommended) {
  //     case "Recomendado Pequena":
  //       return Colors.green;
  //     case "Recomendado Média":
  //       return Colors.orange;
  //     case "Recomendado Grande":
  //       return Colors.blue;
  //     default:
  //       return Colors.grey;
  //   }
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Card(
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
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
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
                                    leading: Icon(Icons.person),
                                    title: Text(
                                      'Nome',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: theme.colorScheme.outline,
                                      ),
                                    ),
                                    subtitle: Text(
                                      family.name,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.phone),
                                    title: Text(
                                      'Telefone',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: theme.colorScheme.outline,
                                      ),
                                    ),
                                    subtitle: Text(
                                      family.mobile_phone,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.group),
                                    title: Text(
                                      'Membros',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: theme.colorScheme.outline,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${family.persons?.length} pessoas',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.attach_money),
                                    title: Text(
                                      'Renda',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: theme.colorScheme.outline,
                                      ),
                                    ),
                                    subtitle: Text(
                                      'R\$ ${family.income}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: const Icon(
                                      Icons.credit_card_rounded,
                                    ),
                                    title: Text(
                                      'CPF',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: theme.colorScheme.outline,
                                      ),
                                    ),
                                    subtitle: Text(
                                      family.cpf,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.location_on),
                                    title: Text(
                                      'Endereço',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: theme.colorScheme.outline,
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${family.street}, n° ${family.number} - ${family.neighborhood}, ${family.city}/${family.state} - ${family.zip_code}',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.article),
                                    title: Text(
                                      'Observações',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: theme.colorScheme.outline,
                                      ),
                                    ),
                                    subtitle: Text(
                                      family.description ?? '',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),

                                  // TODO: Recomendação não está no modelo
                                  // ListTile(
                                  //   leading: const Icon(Icons.star),
                                  //   title: const Text('Recomendação'),
                                  //   subtitle: Text(family.recommended),
                                  // ),

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
                          heroTag: "edit_${family.id}",
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
              // if (selected != null && onSelected != null)
              //   Checkbox(value: selected, onChanged: onSelected)
              // else
              //   const SizedBox.shrink(),
              // const SizedBox(width: 8),
              Expanded(
                child: SizedBox(
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
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        alignment: WrapAlignment.start,
                        children: [
                          // _buildChip(recommended, _getBasketColor(recommended)),
                          _buildChip(family.roleSituation, _getStatusColor()),
                          _buildChip(
                            family.deliveryStatus,
                            _getDeliveryColor(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (family.roleSituation == "Pendente")
                FloatingActionButton.small(
                  heroTag: "calendar_${family.id}",
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
        color: color.withValues(alpha: 0.15),
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
