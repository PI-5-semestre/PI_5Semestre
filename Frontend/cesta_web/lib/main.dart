import 'package:cesta_web/src/views/family/family_page.dart';
import 'package:cesta_web/src/views/family/new_family_page.dart';
import 'package:cesta_web/src/views/home_page.dart';
import 'package:cesta_web/src/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cestas App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF7F9FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF7F9FA),
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
        splashFactory: NoSplash.splashFactory,
        highlightColor: Colors.transparent,
      ),
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyWebScrollBehavior(),
          child: Container(
            color: const Color(0xFFF7F9FA),
            child: SafeArea(child: child!),
          ),
        );
      },
      initialRoute: '/',
      routes: {
        '/': (context) => const ResponsiveScaffold(child: HomePage()),
        '/dasboard': (context) =>
            const ResponsiveScaffold(child: PlaceholderPage(title: 'Dashboard')),
        '/family': (context) => const ResponsiveScaffold(child: FamilyPage()),
        '/family/new_family': (context) =>
            const ResponsiveScaffold(child: NewFamilyPage()),
      },
    );
  }
}

// Scaffold responsivo que usa AppDrawer fixo no web e Drawer no mobile
class ResponsiveScaffold extends StatelessWidget {
  final Widget child;
  const ResponsiveScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: screenWidth < 800
          ? AppBar(title: const Text('Cestas App'))
          : null,
      drawer: screenWidth < 800 ? const AppDrawer() : null,
      body: Row(
        children: [
          if (screenWidth >= 800)
            const SizedBox(
              width: 300,
              child: AppDrawer(), // menu lateral fixo no web
            ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

// Placeholder para Dashboard
class PlaceholderPage extends StatelessWidget {
  final String title;
  const PlaceholderPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title, style: Theme.of(context).textTheme.headlineLarge));
  }
}

// Comportamento global de scroll para Web
class MyWebScrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return Scrollbar(
      child: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: child,
      ),
    );
  }
}
