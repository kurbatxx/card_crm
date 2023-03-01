import 'package:card_crm/main.dart';
import 'package:card_crm/pages/home_page.dart';
import 'package:card_crm/pages/login_page.dart';
import 'package:card_crm/pages/no_internet_page.dart';
import 'package:card_crm/pages/server_setting_page.dart';
import 'package:card_crm/pages/ups_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const App(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/login_page',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/no_internet',
      builder: (context, state) => const NoInternet(),
    ),
    GoRoute(
      path: '/no_server',
      builder: (context, state) => const ServerSettingPage(),
    ),
    GoRoute(
      path: '/ups',
      builder: (context, state) => const UpsPage(),
    ),
  ],
);
