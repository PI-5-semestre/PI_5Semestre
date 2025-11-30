import 'package:flutter/material.dart';
import 'package:cesta_web/src/widgets/app_drawer.dart';
import 'package:go_router/go_router.dart';

class ResponsiveScaffold extends StatelessWidget {
  final StatefulNavigationShell shell;

  const ResponsiveScaffold({
    super.key,
    required this.shell,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth >= 800;

    return Scaffold(
      // MOBILE
      appBar: isWeb
          ? null
          : AppBar(),

      drawer: isWeb ? null : AppDrawer(shell: shell),

      // WEB
      body: Row(
        children: [
          if (isWeb)
            SizedBox(
              width: 300,
              child: AppDrawer(shell: shell),
            ),

          Expanded(
            child: shell,
          ),
        ],
      ),
    );
  }
}
