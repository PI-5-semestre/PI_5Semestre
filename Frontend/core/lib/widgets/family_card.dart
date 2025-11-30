import 'package:core/features/family/data/models/family_model.dart';
import 'package:core/features/family/providers/family_provider.dart';
import 'package:core/widgets/forms/new_visit_form.dart';
import 'package:core/widgets/forms/new_delivery_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
      case "Inativa":
        return Colors.red;
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
                                      '${family.members?.length} pessoas',
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
                                  ListTile(
                                    leading: const Icon(Icons.attachment),
                                    title: Text(
                                      'Comprovantes de Residência',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: theme.colorScheme.outline
                                      ),
                                    ),
                                    subtitle: Consumer(
                                      builder: (context, ref, child) {
                                        final state = ref.watch(familyControllerProvider);
                                        final documents = state.documentsByCpf[family.cpf];

                                        // Busca os documentos quando abrir
                                        WidgetsBinding.instance.addPostFrameCallback((_) {
                                          if (documents == null && !state.isLoading) {
                                            ref.read(familyControllerProvider.notifier).fetchDocuments(family.cpf);
                                          }
                                        });

                                        // Loading inicial
                                        if (state.isLoading && documents == null) {
                                          return const Padding(
                                            padding: EdgeInsets.only(top: 4),
                                            child: Text("Carregando..."),
                                          );
                                        }

                                        // Sem documentos
                                        if (documents == null || documents.isEmpty) {
                                          return const Padding(
                                            padding: EdgeInsets.only(top: 4),
                                            child: Text("Nenhum comprovante enviado"),
                                          );
                                        }

                                        // Lista de documentos
                                        return Padding(
                                          padding: const EdgeInsets.only(top: 4),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: documents.map((doc) {
                                              final filename = doc['file_name'] ?? 'Arquivo sem nome';
                                              final type = doc['mime_type']?.toString().toLowerCase() ?? '';
                                              final id = doc['id'];

                                              IconData icon;
                                              Color iconColor;

                                              if (type.contains('pdf')) {
                                                icon = Icons.picture_as_pdf;
                                                iconColor = Colors.red;
                                              } else if (type.contains('image')) {
                                                icon = Icons.image;
                                                iconColor = Colors.green;
                                              } else {
                                                icon = Icons.insert_drive_file;
                                                iconColor = Colors.blue;
                                              }

                                              return Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  borderRadius: BorderRadius.circular(6),
                                                  onTap: () {
                                                    ref.read(familyControllerProvider.notifier)
                                                      .downloadDocument(family.cpf, id);
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(8), // 👈 Aqui
                                                    child: Row(
                                                      children: [
                                                        // Ícone do tipo
                                                        Container(
                                                          padding: const EdgeInsets.all(6),
                                                          decoration: BoxDecoration(
                                                            color: iconColor.withValues(alpha: 0.12),
                                                            borderRadius: BorderRadius.circular(6),
                                                          ),
                                                          child: Icon(icon, size: 18, color: iconColor),
                                                        ),

                                                        const SizedBox(width: 10),

                                                        Expanded(
                                                          child: Text(
                                                            filename,
                                                            style: const TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),

                                                        Padding(
                                                          padding: const EdgeInsets.only(right: 6),
                                                          child: state.currentDownloadId == id
                                                              ? const SizedBox(
                                                                  width: 18,
                                                                  height: 18,
                                                                  child: CircularProgressIndicator(strokeWidth: 2),
                                                                )
                                                              : const SizedBox(width: 18), // garantindo alinhamento
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        );
                                      },
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

                      Stack(
                        children: [
                          Positioned(
                            bottom: 16,
                            left: 16,
                            child: Consumer(
                              builder: (context, ref, _) {
                                final isLoading = ref.watch(familyControllerProvider).isLoading;
                                final theme = Theme.of(context);

                                return FloatingActionButton(
                                  heroTag: "delete_${family.id}",
                                  onPressed: isLoading
                                      ? null
                                      : () async {
                                          final confirm = await showDialog<bool>(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text('Excluir Funcionário'),
                                                content: Text(
                                                  'Tem certeza que deseja excluir '
                                                  '${family.name}?',
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(context, false),
                                                    child: const Text('Cancelar'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(context, true),
                                                    child: const Text(
                                                      'Excluir',
                                                      style: TextStyle(color: Colors.red),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                          if (confirm != true) return;
                                          await ref.read(familyControllerProvider.notifier).deleteFamily(family.cpf);
                                          final error = ref.read(familyControllerProvider).error;
                                          if (error == null) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: const Text(
                                                  "Família excluída com sucesso!",
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                                backgroundColor: theme.colorScheme.primary,
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text(
                                                  error,
                                                  style: TextStyle(color: theme.colorScheme.onError),
                                                ),
                                                backgroundColor: theme.colorScheme.error,
                                              ),
                                            );
                                          }
                                          Navigator.pop(context);
                                        },
                                  backgroundColor: theme.colorScheme.surfaceContainerLow,
                                  child: isLoading
                                      ? const SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: CircularProgressIndicator(strokeWidth: 3),
                                        )
                                      : const Icon(Icons.delete),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 16,
                            right: 16,
                            child: FloatingActionButton(
                              heroTag: "edit_${family.id}",
                              onPressed: () {
                                context.go(
                                  '/family/edit_family',
                                  extra: family,
                                );
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.edit),
                            ),
                          ),
                        ],
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
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (family.roleSituation == "Inativa")
                FloatingActionButton.small(
                  heroTag: "calendar_${family.id}",
                  elevation: 1,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                        ),
                        builder: (_) => NewVisitForm(family_id: family.id ?? 0,),
                      );
                    },
                  child: const Icon(Icons.calendar_today),
                )

              else if (family.roleSituation == "Pendente")
                FloatingActionButton.small(
                  heroTag: "entrega_${family.id}",
                  elevation: 1,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                        ),
                        builder: (_) => NewDeliveryForm(family_id: family.id ?? 0,),
                      );
                    },
                  child: const Icon(Icons.local_shipping),
                )
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
