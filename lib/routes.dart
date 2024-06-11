import 'package:cartao_acessorios/modules/home_cartao/presenter/home_page.dart';
import 'package:cartao_acessorios/modules/login/presenter/login_page.dart';
import 'package:cartao_acessorios/modules/login/presenter/splash_page.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(routes: [
  GoRoute(
    path: '/splash',
    builder: (context, state) => const SplashPage(),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    path: '/',
    builder: (context, state) => const LoginPage(),
  )
]);
