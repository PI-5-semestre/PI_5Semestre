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
        return const Color(0xFF016630);
      case "Pendente":
        return Colors.orange;
      case "Inativa":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final bool isMobile = constraints.maxWidth < 600;

                  // =========== MOBILE: tela inteira ===========
                  if (isMobile) {
                    return Scaffold(
                      backgroundColor: Colors.black54,
                      body: SafeArea(
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          child: _FamilyDetailsModal(
                            family: family,
                            ref: ref,
                            isMobile: true,
                            onClose: () => Navigator.pop(context),
                          ),
                        ),
                      ),
                    );
                  }

                  // =========== WEB: modal limitado ===========
                  final maxWidth = (constraints.maxWidth > 800 ? 800 : constraints.maxWidth * 0.95).toDouble();
                  final maxHeight = (constraints.maxHeight > 650 ? 650 : constraints.maxHeight * 0.90).toDouble();

                  return Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: maxWidth,
                        maxHeight: maxHeight,
                      ),
                      child: Material(
                        elevation: 12,
                        borderRadius: BorderRadius.circular(16),
                        clipBehavior: Clip.hardEdge,
                        color: theme.colorScheme.surface,
                        child: _FamilyDetailsModal(
                          family: family,
                          ref: ref,
                          isMobile: false,
                          onClose: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },

        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
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
                      children: [
                        _buildChip(family.roleSituation, _getStatusColor()),
                      ],
                    ),
                  ],
                ),
              ),

              if (family.roleSituation == "Inativa")
                FloatingActionButton.small(
                  heroTag: "calendar_${family.id}",
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: theme.colorScheme.surfaceContainerLow,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      builder: (_) => NewVisitForm(family_id: family.id ?? 0),
                    );
                  },
                  child: const Icon(Icons.calendar_today),
                ),

              if (family.roleSituation == "Pendente")
                FloatingActionButton.small(
                  heroTag: "delivery_${family.id}",
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: theme.colorScheme.surfaceContainerLow,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      builder: (_) => NewDeliveryForm(family_id: family.id ?? 0),
                    );
                  },
                  child: const Icon(Icons.local_shipping),
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
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(8),
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

//////////////////////////////////////////////////////////////////
///     CONTEÚDO COMPLETO DO MODAL – NADA FOI REMOVIDO!!!       ///
//////////////////////////////////////////////////////////////////

class _FamilyDetailsModal extends StatelessWidget {
  final FamilyModel family;
  final WidgetRef ref;
  final bool isMobile;
  final VoidCallback onClose;

  const _FamilyDetailsModal({
    required this.family,
    required this.ref,
    required this.isMobile,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // ======= CABEÇALHO =======
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Detalhes da Família',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: onClose,
              ),
            ],
          ),
        ),

        const Divider(height: 1),

        // ======= CONTEÚDO ROLÁVEL COMPLETO =======
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Nome'),
                subtitle: Text(family.name),
              ),

              ListTile(
                leading: const Icon(Icons.phone),
                title: const Text('Telefone'),
                subtitle: Text(family.mobile_phone),
              ),

              ListTile(
                leading: const Icon(Icons.group),
                title: const Text('Membros'),
                subtitle: Text('${family.members?.length ?? 0} pessoas'),
              ),

              ListTile(
                leading: const Icon(Icons.attach_money),
                title: const Text('Renda'),
                subtitle: Text('R\$ ${family.income}'),
              ),

              ListTile(
                leading: const Icon(Icons.credit_card_rounded),
                title: const Text('CPF'),
                subtitle: Text(family.cpf),
              ),

              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text('Endereço'),
                subtitle: Text(
                  '${family.street}, n° ${family.number} - ${family.neighborhood}, '
                  '${family.city}/${family.state} - ${family.zip_code}',
                ),
              ),

              ListTile(
                leading: const Icon(Icons.article),
                title: const Text('Observações'),
                subtitle: Text(family.description ?? ''),
              ),

              // ================= DOCUMENTOS =================
              ListTile(
                leading: const Icon(Icons.attachment),
                title: const Text('Comprovantes de Residência'),
                subtitle: Consumer(
                  builder: (context, ref, child) {
                    final state = ref.watch(familyControllerProvider);
                    final documents = state.documentsByCpf[family.cpf];

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (documents == null && !state.isLoading) {
                        ref.read(familyControllerProvider.notifier).fetchDocuments(family.cpf);
                      }
                    });

                    if (state.isLoading && documents == null) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 4), 
                        child: Text("Carregando..."),
                      );
                    }

                    if (documents == null || documents.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 4), 
                        child: Text("Nenhum comprovante enviado"),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: documents.map((doc) {
                        final filename = doc['file_name'] ?? 'Arquivo sem nome';
                        final type = doc['mime_type']?.toString().toLowerCase() ?? '';
                        final id = doc['id'];

                        IconData icon;
                        Color iconColor;

                        if (type.contains('pdf')) {
                          icon = Icons.picture_as_pdf; iconColor = Colors.red;
                        } else if (type.contains('image')) {
                          icon = Icons.image; iconColor = Colors.green;
                        } else {
                          icon = Icons.insert_drive_file; iconColor = Colors.blue;
                        }

                        return InkWell(
                          onTap: () {
                            ref.read(familyControllerProvider.notifier).downloadDocument(family.cpf, id);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: iconColor.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Icon(icon, size: 18, color: iconColor),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    filename,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (state.currentDownloadId == id)
                                  const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),

        // ======= RODAPÉ COM FLOATING BTNS =======
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                heroTag: "delete_${family.id}",
                backgroundColor: theme.colorScheme.surfaceContainerLow,
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Excluir Família'),
                      content: Text('Deseja excluir ${family.name}?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Excluir', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    await ref.read(familyControllerProvider.notifier).deleteFamily(family.cpf);
                    onClose();
                  }
                },
                child: const Icon(Icons.delete),
              ),

              FloatingActionButton(
                heroTag: "edit_${family.id}",
                onPressed: () {
                  context.go('/family/edit_family', extra: family);
                  onClose();
                },
                child: const Icon(Icons.edit),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
