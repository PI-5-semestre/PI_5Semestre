import 'package:cesta_web/src/views/basket/basket_page.dart';
import 'package:cesta_web/src/views/delivery/delivery_page.dart';
import 'package:cesta_web/src/views/delivery/edit_delivery_page.dart';
import 'package:cesta_web/src/views/family/edit_family_page.dart';
import 'package:cesta_web/src/views/family/family_page.dart';
import 'package:cesta_web/src/views/family/new_family_page.dart';
import 'package:cesta_web/src/views/forgot_password_page.dart';
import 'package:cesta_web/src/views/home_page.dart';
import 'package:cesta_web/src/views/login_page.dart';
import 'package:cesta_web/src/views/new_password_page.dart';
import 'package:cesta_web/src/views/register_page.dart';
import 'package:cesta_web/src/views/stock/new_stock_page.dart';
import 'package:cesta_web/src/views/stock/stock_page.dart';
import 'package:cesta_web/src/views/teams/edit_servant_page.dart';
import 'package:cesta_web/src/views/teams/new_servant_page.dart';
import 'package:cesta_web/src/views/teams/team_page.dart';
import 'package:cesta_web/src/views/visits/edit_visit_page.dart';
import 'package:cesta_web/src/views/visits/visits_page.dart';
import 'package:cesta_web/src/widgets/reponsive_scaffold.dart';
import 'package:core/features/auth/data/models/user.dart';
import 'package:core/features/delivery/data/models/delivery.dart';
import 'package:core/features/family/data/models/family_model.dart';
import 'package:core/features/visits/data/models/visits.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(
  initialLocation: '/login',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          ResponsiveScaffold(shell: navigationShell),
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
                  builder: (context, state) {
                    final family = state.extra as FamilyModel;
                    return EditFamilyPage(family: family);
                  },
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
                  path: 'edit_delivery',
                  builder: (context, state) {
                    final delivery = state.extra as DeliveryModel;
                    return EditDeliveryPage(delivery: delivery);
                  }
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/stock',
              builder: (context, state) => StockPage(),
              routes: [
                GoRoute(
                  path: 'new_stock',
                  builder: (context, state) => NewStockPage(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/visits',
              builder: (context, state) => VisitsPage(),
              routes: [
                GoRoute(
                  path: 'edit_visit',
                  builder: (context, state) {
                    final visit = state.extra as Visit;
                    return EditVisitPage(visit: visit);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/basket',
              builder: (context, state) => BasketPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/team',
              builder: (context, state) => TeamPage(),
              routes: [
                GoRoute(
                  path: 'new_servant',
                  builder: (context, state) => NewServantPage(),
                ),
                GoRoute(
                  path: 'edit_servant',
                  builder: (context, state) {
                    final account = state.extra as Account;
                    return EditServantPage(account: account);
                  },
                ),
                GoRoute(
                  path: 'edit_servant/:id',
                  builder: (context, state) => VisitsPage(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
      routes: [
        GoRoute(path: 'register', builder: (context, state) => RegisterPage()),
        GoRoute(
          path: 'forgot_password',
          builder: (context, state) => ForgotPasswordPage(),
        ),
        GoRoute(
          path: 'new_password',
          builder: (context, state) => NewPasswordPage(),
        ),
      ],
    ),
  ],
);