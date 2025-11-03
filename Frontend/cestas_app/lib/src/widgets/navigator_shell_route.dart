import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigatorShellRouteWidget extends StatelessWidget {
  const NavigatorShellRouteWidget({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      backgroundColor: Colors.white,
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.blue,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: Colors.white);
            }
            return const IconThemeData(color: Colors.blue);
          }),
          labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
            return const TextStyle(color: Colors.blue);
          }),
        ),
        child: NavigationBar(
          //animationDuration: const Duration(milliseconds: 400),
          selectedIndex: shell.currentIndex,
          onDestinationSelected: (index) => shell.goBranch(
            index,
            initialLocation: shell.currentIndex == index,
          ),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Dashboard',
            ),
            NavigationDestination(
              icon: Icon(Icons.group_outlined),
              selectedIcon: Icon(Icons.group),
              label: 'Famílias',
            ),
            NavigationDestination(
              icon: Icon(Icons.local_shipping_outlined),
              selectedIcon: Icon(Icons.local_shipping),
              label: 'Entregas',
            ),
            NavigationDestination(
              icon: Icon(Icons.menu_outlined),
              selectedIcon: Icon(Icons.menu_outlined),
              label: 'Mais',
            ),
          ],
        ),
      ),
    );
  }
}
