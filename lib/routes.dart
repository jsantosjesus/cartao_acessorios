import 'package:cartao_acessorios/modules/get_compra/presenter/compra_page.dart';
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
    path: '/',
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
      path: '/compra/:compraId',
      builder: (context, state) =>
          CompraPage(compraId: state.pathParameters['compraId']!))
]);
