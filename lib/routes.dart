import 'package:cartao_acessorios/modules/login/presenter/home_page.dart';
import 'package:cartao_acessorios/modules/login/presenter/splash_page.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const SplashPage(),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => const HomePage(),
  )
]);
