import 'package:core/features/auth/data/models/user.dart';
import 'package:core/features/user/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class TeamCardModal extends ConsumerWidget {
  final Account account;

  const TeamCardModal({
    super.key,
    required this.account,
  });

  Color _getStatusColor() {
    switch (account.roleName) {
      case "Coordenador":
        return Colors.purple;
      case "Entregador":
        return Colors.blue;
      case "Assistente Social":
        return Colors.green;
      case "Voluntário":
        return Colors.orange;
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
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return Material(
                type: MaterialType.transparency,
                child: SizedBox(
                  height: 500,
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
                                  Text(
                                    'Detalhes do Funcionário',
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
                                      account.profile?.name ?? '',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
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
                                      account.profile?.mobile ?? '',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.email),
                                    title: Text(
                                      'Email',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: theme.colorScheme.outline,
                                      ),
                                    ),
                                    subtitle: Text(
                                      account.email,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.badge),
                                    title: Text(
                                      'CPF',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: theme.colorScheme.outline,
                                      ),
                                    ),
                                    subtitle: Text(
                                      account.profile?.cpf ?? '',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.work),
                                    title: Text(
                                      'Atividade',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: theme.colorScheme.outline,
                                      ),
                                    ),
                                    subtitle: Text(
                                      account.roleName,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.calendar_today),
                                    title: Text(
                                      'Início',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: theme.colorScheme.outline,
                                      ),
                                    ),
                                    subtitle: Text(
                                      DateFormat('dd/MM/yyyy').format(DateTime.parse(account.created)),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: theme.colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
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
                                final isLoading = ref.watch(userControllerProvider).isLoading;
                                final theme = Theme.of(context);

                                return FloatingActionButton(
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
                                                  '${account.profile?.name ?? ''}?',
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
                                          await ref
                                              .read(userControllerProvider.notifier)
                                              .deleteUser(account.email);
                                          final error = ref.read(userControllerProvider).error;
                                          if (error == null) {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text("Usuário excluído com sucesso!"),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text(error)),
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
                              onPressed: () {
                                context.go(
                                  '/more/team/edit_servant',
                                  extra: account,
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
        child: SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  account.profile?.name ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Wrap(
                  spacing: 6,
                  runSpacing: -6,
                  children: [_buildChip(account.roleName, _getStatusColor())],
                ),
              ],
            ),
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
