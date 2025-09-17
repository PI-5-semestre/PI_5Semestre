import 'package:cestas_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teste'),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: const AppDrawer(),
      body: ListView(
        children: const [
          ListTile(title: Text('Item 1')),
          ListTile(title: Text('Item 2')),
        ],
      ),
    );
  }
}
