import 'package:card_crm/main.dart';
import 'package:card_crm/pages/login_page.dart';
import 'package:card_crm/pages/ups_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const App(),
    ),
    GoRoute(
      path: '/login_page',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/ups',
      builder: (context, state) => const UpsPage(),
    ),
  ],
);
