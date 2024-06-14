import 'package:cartao_acessorios/modules/home/home_page.dart';
import 'package:cartao_acessorios/modules/login/presenter/login_page.dart';
import 'package:go_router/go_router.dart';

final routes = GoRouter(routes: [
  GoRoute(
    path: '/home/:uid',
    builder: (context, state) => HomePage(
      uid: state.pathParameters['uid']!,
    ),
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: '/',
    builder: (context, state) => const HomePage(
      uid: 'Zo5szZw2uIXjEiNTc9PhKADmiq92',
    ),
  )
]);
