import 'package:cartao_acessorios/modules/login/datasource/firebase_authentication_datasource.dart';
import 'package:cartao_acessorios/modules/login/presenter/store/login_store.dart';
import 'package:cartao_acessorios/modules/login/repository/firebase_authentication_repository.dart';
import 'package:cartao_acessorios/modules/login/services/salve_storage/securit_storage/securit_storage.dart';
// import 'package:cartao_acessorios/modules/login/utils/salve_storage/shared_preferences.dart/prefs_service.dart';
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
    storage: SecuritStorage(),
  );

  bool checkAutoLogin = false;

  void checkLogin() async {
    checkAutoLogin = await store.checkCanAuthomaticLogin();
    // print(checkAutoLogin);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

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
                final String uid = store.success.value;
                Future.delayed(Duration.zero, () {
                  context.go('/home/$uid');
                });
                return const Center();
              } else {
                return const Center(
                  child: Text('erro desconhecido'),
                );
              }
            }),
          ),
          if (checkAutoLogin)
            ElevatedButton(
                onPressed: () {
                  store.getUserStorage();
                },
                child: const Text('Entrar com senha'))
        ],
      ),
    );
  }
}
