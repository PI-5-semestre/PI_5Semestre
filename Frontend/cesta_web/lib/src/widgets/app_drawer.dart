import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isSmallScreen = screenWidth > 800;

    return Container(
      margin: const EdgeInsets.only(right: 16), // espaço para a sombra
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
          backgroundColor: Colors.white,
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
                  decoration: const BoxDecoration(color: Colors.white),
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
                              color: Colors.black,
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
                        onTap: () =>
                            Navigator.pushReplacementNamed(context, '/'),
                      ),
                      _buildMenuItem(
                        context,
                        icon: Icons.group,
                        iconColor: Colors.green,
                        iconBg: Colors.green[100]!,
                        title: 'Famílias',
                        onTap: () => Navigator.pushNamed(context, '/family'),
                      ),
                      _buildMenuItem(
                        context,
                        icon: Icons.inventory,
                        iconColor: Colors.purple,
                        iconBg: Colors.purple[100]!,
                        title: 'Estoque',
                        onTap: () => Navigator.pushNamed(context, "/stock"),
                      ),
                      _buildMenuItem(
                        context,
                        icon: Icons.shopping_cart,
                        iconColor: Colors.orange,
                        iconBg: Colors.orange[100]!,
                        title: 'Cestas',
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        context,
                        icon: Icons.local_shipping,
                        iconColor: Colors.blue,
                        iconBg: Colors.blue[100]!,
                        title: 'Entregas',
                        onTap: () {},
                      ),
                      _buildMenuItem(
                        context,
                        icon: FontAwesomeIcons.calendar,
                        iconColor: Colors.blue,
                        iconBg: Colors.blue[100]!,
                        title: 'Visitas',
                        onTap: () {
                          Navigator.pushNamed(context, '/visits');
                        },
                      ),
                      _buildMenuItem(
                        context,
                        icon: FontAwesomeIcons.circleUser,
                        iconColor: Colors.blue,
                        iconBg: Colors.blue[100]!,
                        title: 'Tela de Login',
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                      ),
                    ],
                  ),
                ),
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
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
      dense: false, // deixa o item mais alto
      minVerticalPadding: 8, // aumenta ainda mais a altura
    );
  }
}
