import 'package:cartao_acessorios/modules/login/datasource/firebase_authentication_datasource.dart';
import 'package:cartao_acessorios/modules/login/presenter/store/login_store.dart';
import 'package:cartao_acessorios/modules/login/repository/firebase_authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final store = LoginStore(
    authentication: FirebaseAuthenticationRepository(
      datasource: FirebaseAuthenticationDatasourceImpl(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('login'),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              store.setEmail(value);
            },
            decoration: const InputDecoration(labelText: 'Seu e-mail'),
          ),
          TextField(
            onChanged: (value) {
              store.setPassword(value);
            },
            decoration: const InputDecoration(labelText: 'Sua senha'),
          ),
          ElevatedButton(
            onPressed: () {
              store.authenticationEmailAndPassword();
            },
            child: const Text('Entrar'),
          ),
          ElevatedButton(
            onPressed: () {
              store.getUserShared();
            },
            child: const Text('usar faceId'),
          ),
          AnimatedBuilder(
            animation: Listenable.merge([
              store.error,
              store.isLoading,
              store.success,
              store.initialState
            ]),
            builder: ((context, child) {
              if (store.initialState.value) {
                return const Center();
              } else if (store.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (store.error.value.isNotEmpty) {
                return Center(
                  child: Text(store.error.value),
                );
              } else if (store.success.value.isNotEmpty) {
                Future.delayed(Duration.zero, () {
                  context.go('/home');
                });
                return const Center();
              } else {
                return const Center(
                  child: Text('erro desconhecido'),
                );
              }
            }),
          )
        ],
      ),
    );
  }
}
