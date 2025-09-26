import 'package:cestas_app/pages/delivery/delivery_page.dart';
import 'package:cestas_app/pages/delivery/new_delivery_page.dart';
import 'package:cestas_app/pages/family/family_page.dart';
import 'package:cestas_app/pages/family/new_family_page.dart';
import 'package:cestas_app/pages/forgot_password_page.dart';
import 'package:cestas_app/pages/home_page.dart';
import 'package:cestas_app/pages/login_page.dart';
import 'package:cestas_app/pages/new_password_page.dart';
import 'package:cestas_app/pages/register_page.dart';
import 'package:cestas_app/pages/visits_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cestas_app/pages/stock/stock_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:cestas_app/pages/basket/basket_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt', 'BR'), Locale('en', 'US')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      title: 'Cestas App',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF7F9FA),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFF7F9FA),
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
          titleTextStyle: const TextStyle(
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
        return Container(
          child: SafeArea(child: child!),
          color: Color(0xFFF7F9FA),
        );
      },
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/dasboard': (context) => Scaffold(
          appBar: AppBar(title: Text('Dashboard')),
          body: Placeholder(),
        ),
        '/family': (context) => FamilyPage(),
        '/family/new_family': (context) => NewFamilyPage(),
        '/stock': (context) => StockPage(),
        '/delivery': (context) => DeliveryPage(),
        '/delivery/new_delivery': (context) => NewDeliveryPage(),
        '/visits': (context) => VisitsPage(),
        '/basket': (context) => BasketPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/forgot_password': (context) => ForgotPasswordPage(),
        '/new_password': (context) => NewPasswordPage(),
      },
    );
  }
}
