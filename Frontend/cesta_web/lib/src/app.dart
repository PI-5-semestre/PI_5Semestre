import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:cesta_web/src/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:core/ui/theme.dart';
import 'package:core/ui/util.dart';

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
      theme: (brightness == Brightness.light ? theme.dark() : theme.light()).copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
      ),
      // theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      routerDelegate: routes.routerDelegate,
      routeInformationParser: routes.routeInformationParser,
      routeInformationProvider: routes.routeInformationProvider,
    );
  }
}
