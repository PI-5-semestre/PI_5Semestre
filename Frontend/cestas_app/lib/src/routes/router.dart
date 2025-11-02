import 'package:cestas_app/src/pages/basket/basket_page.dart';
import 'package:cestas_app/src/pages/delivery/delivery_page.dart';
import 'package:cestas_app/src/pages/delivery/new_delivery_page.dart';
import 'package:cestas_app/src/pages/family/edit_family_page.dart';
import 'package:cestas_app/src/pages/family/family_page.dart';
import 'package:cestas_app/src/pages/family/new_family_page.dart';
import 'package:cestas_app/src/pages/forgot_password_page.dart';
import 'package:cestas_app/src/pages/home_page.dart';
import 'package:cestas_app/src/pages/login_page.dart';
import 'package:cestas_app/src/pages/more_page.dart';
import 'package:cestas_app/src/pages/new_password_page.dart';
import 'package:cestas_app/src/pages/register_page.dart';
import 'package:cestas_app/src/pages/stock/stock_page.dart';
import 'package:cestas_app/src/pages/team_page.dart';
import 'package:cestas_app/src/pages/visits_page.dart';
import 'package:cestas_app/src/widgets/navigator_shell_route.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          NavigatorShellRouteWidget(shell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) => HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/family',
              builder: (context, state) => FamilyPage(),
              routes: [
                GoRoute(
                  path: 'new_family',
                  builder: (context, state) => NewFamilyPage(),
                ),
                GoRoute(
                  path: 'edit_family',
                  builder: (context, state) => EditFamilyPage(),
                ),
                GoRoute(
                  path: 'edit_family/:id',
                  builder: (context, state) => EditFamilyPage(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/delivery',
              builder: (context, state) => DeliveryPage(),
              routes: [
                GoRoute(
                  path: 'new_delivery',
                  builder: (context, state) => NewDeliveryPage(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/more',
              builder: (context, state) => MorePage(),
              routes: [
                GoRoute(
                  path: 'stock',
                  builder: (context, state) => StockPage(),
                ),
                GoRoute(
                  path: 'visits',
                  builder: (context, state) => VisitsPage(),
                ),
                GoRoute(
                  path: 'basket',
                  builder: (context, state) => BasketPage(),
                ),
                GoRoute(
                  path: 'login',
                  builder: (context, state) => LoginPage(),
                ),
                GoRoute(
                  path: 'register',
                  builder: (context, state) => RegisterPage(),
                ),
                GoRoute(
                  path: 'forgot_password',
                  builder: (context, state) => ForgotPasswordPage(),
                ),
                GoRoute(
                  path: 'new_password',
                  builder: (context, state) => NewPasswordPage(),
                ),
                GoRoute(path: 'team', builder: (context, state) => TeamPage()),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
