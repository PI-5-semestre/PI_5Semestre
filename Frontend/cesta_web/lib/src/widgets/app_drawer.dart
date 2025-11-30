import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, this.shell});

  final StatefulNavigationShell? shell;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isSmallScreen = screenWidth > 800;

    return Container(
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(1, 0),
          ),
        ],
      ),
      child: ClipRect(
        child: Drawer(
          shape: isSmallScreen
              ? const RoundedRectangleBorder(borderRadius: BorderRadius.zero)
              : const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
          child: SafeArea(
            child: Column(
              children: [
                DrawerHeader(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          FontAwesomeIcons.heart,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Cestas de Amor',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Igreja Comunidade',
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ---------------- MENU ----------------
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    children: [
                      _buildMenuItem(
                        context,
                        icon: Icons.home,
                        iconColor: Colors.white,
                        iconBg: Colors.blueAccent,
                        title: 'Dashboard',
                        onTap: () {
                          shell!.goBranch(0);
                        },
                      ),
                      _buildMenuItem(
                        context,
                        icon: Icons.group,
                        iconColor: Colors.green,
                        iconBg: Colors.greenAccent.shade100,
                        title: 'Famílias',
                        onTap: () {
                          shell!.goBranch(1);
                        },
                      ),
                      _buildMenuItem(
                        context,
                        icon: Icons.local_shipping,
                        iconColor: Colors.blue,
                        iconBg: Colors.blue.shade100,
                        title: 'Entregas',
                        onTap: () {
                          shell!.goBranch(2);
                        },
                      ),
                      _buildMenuItem(
                        context,
                        icon: Icons.inventory,
                        iconColor: Colors.purple,
                        iconBg: Colors.purple.shade100,
                        title: 'Estoque',
                        onTap: () {
                          shell!.goBranch(3);
                          context.go('/stock');
                        },
                      ),
                      _buildMenuItem(
                        context,
                        icon: FontAwesomeIcons.calendar,
                        iconColor: Colors.blue,
                        iconBg: Colors.blue.shade100,
                        title: 'Visitas',
                        onTap: () {
                          shell!.goBranch(3);
                          context.go('/visits');
                        },
                      ),
                      _buildMenuItem(
                        context,
                        icon: Icons.shopping_basket,
                        iconColor: Colors.orange,
                        iconBg: Colors.orange.shade100,
                        title: 'Cestas',
                        onTap: () {
                          shell!.goBranch(3);
                          context.go('/basket');
                        },
                      ),
                      _buildMenuItem(
                        context,
                        icon: FontAwesomeIcons.peopleGroup,
                        iconColor: Colors.blue,
                        iconBg: Colors.blue.shade100,
                        title: 'Equipe',
                        onTap: () {
                          shell!.goBranch(3);
                          context.go('/team');
                        },
                      ),
                      _buildMenuItem(
                        context,
                        icon: FontAwesomeIcons.circleUser,
                        iconColor: Colors.blue,
                        iconBg: Colors.blue.shade100,
                        title: 'Tela de Login',
                        onTap: () {
                          context.go('/login');
                        },
                      ),
                    ],
                  ),
                ),

                // ---------------- USUÁRIO ----------------
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pastor João Silva',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Coordenador',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.logout),
                        label: const Text('Sair'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: iconBg,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      onTap: onTap,
      dense: false,
      minVerticalPadding: 8,
    );
  }
}
