import 'package:cestas_app/src/pages/basket/basket_page.dart';
import 'package:cestas_app/src/pages/delivery/delivery_page.dart';
import 'package:cestas_app/src/pages/delivery/new_delivery_page.dart';
import 'package:cestas_app/src/pages/family/family_page.dart';
import 'package:cestas_app/src/pages/family/edit_family_page.dart';
import 'package:cestas_app/src/pages/family/new_family_page.dart';
import 'package:cestas_app/src/pages/forgot_password_page.dart';
import 'package:cestas_app/src/pages/home_page.dart';
import 'package:cestas_app/src/pages/login_page.dart';
import 'package:cestas_app/src/pages/new_password_page.dart';
import 'package:cestas_app/src/pages/register_page.dart';
import 'package:cestas_app/src/pages/stock/stock_page.dart';
import 'package:cestas_app/src/pages/team_page.dart';
import 'package:cestas_app/src/pages/visits_page.dart';
import 'package:core/ui/theme.dart';
import 'package:core/ui/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "Outfit", "Outfit");
    
    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt', 'BR'), Locale('en', 'US')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      title: 'Cestas App',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      // theme: brightness == Brightness.light ? theme.dark() : theme.light(),
      // theme: ThemeData(
      //   scaffoldBackgroundColor: Color(0xFFF7F9FA),
      //   appBarTheme: AppBarTheme(
      //     backgroundColor: Color(0xFFF7F9FA),
      //     elevation: 0,
      //     surfaceTintColor: Colors.transparent,
      //     iconTheme: const IconThemeData(color: Colors.black),
      //     titleTextStyle: const TextStyle(
      //       color: Colors.black,
      //       fontSize: 20,
      //       fontWeight: FontWeight.w600,
      //     ),
      //   ),
      //   textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
      //   splashFactory: NoSplash.splashFactory,
      //   highlightColor: Colors.transparent,
      // ),
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
        '/family/edit_family': (context) => EditFamilyPage(),
        '/stock': (context) => StockPage(),
        '/delivery': (context) => DeliveryPage(),
        '/delivery/new_delivery': (context) => NewDeliveryPage(),
        '/visits': (context) => VisitsPage(),
        '/basket': (context) => BasketPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/forgot_password': (context) => ForgotPasswordPage(),
        '/new_password': (context) => NewPasswordPage(),
        '/team': (context) => TeamPage(),
      },
    );
  }
}
