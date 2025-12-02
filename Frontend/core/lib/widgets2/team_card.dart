import 'package:core/features/auth/data/models/user.dart';
import 'package:core/features/user/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class TeamCardModal extends ConsumerWidget {
  final Account account;
  final String? appType;

  const TeamCardModal({
    super.key,
    required this.account,
    this.appType = 'app'
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
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final bool isMobile = constraints.maxWidth < 600;

                  if (isMobile) {
                    return Scaffold(
                      backgroundColor: Colors.black54,
                      body: SafeArea(
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius:
                                const BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          child: _TeamModalContent(
                            account: account,
                            ref: ref,
                            appType: appType,
                            onClose: () => Navigator.pop(context),
                            isMobile: true,
                          ),
                        ),
                      ),
                    );
                  }

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
                        clipBehavior: Clip.hardEdge,
                        borderRadius: BorderRadius.circular(16),
                        color: theme.colorScheme.surface,
                        child: _TeamModalContent(
                          account: account,
                          ref: ref,
                          appType: appType,
                          onClose: () => Navigator.pop(context),
                          isMobile: false,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },

        child: SizedBox(
          height: 80,
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
                  children: [
                    _buildChip(account.roleName, _getStatusColor()),
                  ],
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
        color: color.withOpacity(0.15),
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

class _TeamModalContent extends StatelessWidget {
  final Account account;
  final WidgetRef ref;
  final VoidCallback onClose;
  final String? appType;
  final bool isMobile;

  const _TeamModalContent({
    required this.account,
    required this.ref,
    required this.onClose,
    required this.appType,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = ref.watch(userControllerProvider.notifier);
    final state = ref.watch(userControllerProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Detalhes do Funcionário',
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

        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            children: [
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Nome'),
                subtitle: Text(account.profile?.name ?? ''),
              ),
              ListTile(
                leading: const Icon(Icons.phone),
                title: const Text('Telefone'),
                subtitle: Text(account.profile?.mobile ?? ''),
              ),
              ListTile(
                leading: const Icon(Icons.email),
                title: const Text('Email'),
                subtitle: Text(account.email),
              ),
              ListTile(
                leading: const Icon(Icons.badge),
                title: const Text('CPF'),
                subtitle: Text(account.profile?.cpf ?? ''),
              ),
              ListTile(
                leading: const Icon(Icons.work),
                title: const Text('Atividade'),
                subtitle: Text(account.roleName),
              ),
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('Início'),
                subtitle: Text(
                  DateFormat('dd/MM/yyyy').format(DateTime.parse(account.created)),
                ),
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                heroTag: "delete_${account.email}",
                backgroundColor: theme.colorScheme.surfaceContainerLow,
                onPressed: state.isLoading
                    ? null
                    : () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Excluir Funcionário"),
                            content: Text(
                              "Deseja realmente excluir ${account.profile?.name}?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text("Cancelar"),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text("Excluir",
                                    style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          ),
                        );

                        if (confirm != true) return;

                        await controller.deleteUser(account.email);

                        final error = ref.read(userControllerProvider).error;

                        if (error != null) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(error)));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  content: Text("Usuário excluído com sucesso!")));
                        }

                        onClose();
                      },
                child: state.isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(strokeWidth: 3),
                      )
                    : const Icon(Icons.delete),
              ),

              FloatingActionButton(
                heroTag: "edit_${account.email}",
                onPressed: () {
                  context.go(
                    appType == 'app' 
                    ? '/more/team/edit_servant'
                    : '/team/edit_servant',
                    extra: account
                  );
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
