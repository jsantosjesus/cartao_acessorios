import 'package:cartao_acessorios/modules/login/presenter/login_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Container(
        color: Colors.black26,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.yellowAccent,
          ),
        ),
      );
    } else {
      return const LoginPage();
    }
  }
}
