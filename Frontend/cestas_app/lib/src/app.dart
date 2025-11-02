import 'package:cestas_app/src/routes/router.dart';
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
    return MaterialApp.router(
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt', 'BR'), Locale('en', 'US')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      title: 'Cestas App',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      routerDelegate: routes.routerDelegate,
      routeInformationParser: routes.routeInformationParser,
      routeInformationProvider: routes.routeInformationProvider,

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
      // builder: (context, child) {
      //   return Container(
      //     child: SafeArea(child: child!),
      //     color: Color(0xFFF7F9FA),
      //   );
      // },
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => HomePage(),
      //   '/dasboard': (context) => Scaffold(
      //     appBar: AppBar(title: Text('Dashboard')),
      //     body: Placeholder(),
      //   ),
      //   '/family': (context) => FamilyPage(),
      //   '/family/new_family': (context) => NewFamilyPage(),
      //   '/family/edit_family': (context) => EditFamilyPage(),
      //   '/stock': (context) => StockPage(),
      //   '/delivery': (context) => DeliveryPage(),
      //   '/delivery/new_delivery': (context) => NewDeliveryPage(),
      //   '/visits': (context) => VisitsPage(),
      //   '/basket': (context) => BasketPage(),
      //   '/login': (context) => LoginPage(),
      //   '/register': (context) => RegisterPage(),
      //   '/forgot_password': (context) => ForgotPasswordPage(),
      //   '/new_password': (context) => NewPasswordPage(),
      // },
    );
  }
}
