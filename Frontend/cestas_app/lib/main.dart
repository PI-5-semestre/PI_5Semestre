import 'package:cestas_app/pages/family_page.dart';
import 'package:cestas_app/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cestas App',
      // theme: ThemeData(
      //   fontFamily: 'Montserrat'
      // ),
      initialRoute: '/',
      routes: {
        '/' : (context) => HomePage(),
        '/dasboard' : (context) => Scaffold(appBar: AppBar(title: Text('Dashboard'),), body: Placeholder(),),
        '/family' : (context) => FamilyPage(),
      }
    );
  }
}
