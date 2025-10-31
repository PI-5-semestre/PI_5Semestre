import 'package:cestas_app/src/pages/basket/basket_page.dart';
import 'package:cestas_app/src/pages/delivery/delivery_page.dart';
import 'package:cestas_app/src/pages/delivery/new_delivery_page.dart';
import 'package:cestas_app/src/pages/family/edit_family_page.dart';
import 'package:cestas_app/src/pages/family/family_page.dart';
import 'package:cestas_app/src/pages/family/new_family_page.dart';
import 'package:cestas_app/src/pages/forgot_password_page.dart';
import 'package:cestas_app/src/pages/home_page.dart';
import 'package:cestas_app/src/pages/login_page.dart';
import 'package:cestas_app/src/pages/new_password_page.dart';
import 'package:cestas_app/src/pages/register_page.dart';
import 'package:cestas_app/src/pages/stock/stock_page.dart';
import 'package:cestas_app/src/pages/visits_page.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(path: '/family', builder: (context, state) => FamilyPage()),
    GoRoute(
      path: '/family/new_family',
      builder: (context, state) => NewFamilyPage(),
    ),
    GoRoute(
      path: '/family/edit_family',
      builder: (context, state) => EditFamilyPage(),
    ),
    GoRoute(
      path: '/family/edit_family/:id',
      builder: (context, state) => EditFamilyPage(),
    ),
    GoRoute(path: '/stock', builder: (context, state) => StockPage()),
    GoRoute(path: '/delivery', builder: (context, state) => DeliveryPage()),
    GoRoute(
      path: '/delivery/new_delivery',
      builder: (context, state) => NewDeliveryPage(),
    ),
    GoRoute(path: '/visits', builder: (context, state) => VisitsPage()),
    GoRoute(path: '/basket', builder: (context, state) => BasketPage()),
    GoRoute(path: '/login', builder: (context, state) => LoginPage()),
    GoRoute(path: '/register', builder: (context, state) => RegisterPage()),
    GoRoute(
      path: '/forgot_password',
      builder: (context, state) => ForgotPasswordPage(),
    ),
    GoRoute(
      path: '/new_password',
      builder: (context, state) => NewPasswordPage(),
    ),
    // GoRoute(path: '/family', builder: (context, state) => FamilyPage()),
  ],
);
