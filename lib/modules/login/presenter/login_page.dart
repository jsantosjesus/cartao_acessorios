import 'package:cartao_acessorios/global_styles_config/styles_global.dart';
import 'package:cartao_acessorios/modules/login/datasource/firebase_authentication_datasource.dart';
import 'package:cartao_acessorios/modules/login/presenter/components/gradient_button.dart';
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
      backgroundColor: const Color(0XFF1F1F1F),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 80, left: 20),
                  width: 250,
                  child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Seja Bem vindo',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontFamily: fontGlobal,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.end,
                        ),
                        Text(
                          'Controle seus gastos com o cartão Acessorios',
                          textAlign: TextAlign.end,
                          style: TextStyle(color: Colors.white),
                        ),
                      ]),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(top: 40, bottom: 20),
              child: Text(
                'Faça Login',
                style: TextStyle(
                    fontFamily: fontGlobal,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextField(
                onChanged: (value) {
                  store.setEmail(value);
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelStyle: TextStyle(fontFamily: fontGlobal),
                  labelText: 'Seu email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextField(
                onChanged: (value) {
                  store.setPassword(value);
                },
                obscureText: true,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  labelStyle: TextStyle(fontFamily: fontGlobal),
                  labelText: 'Sua senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ),
            GradientButton(
              onPressed: () {
                store.authenticationEmailAndPassword();
              },
              text: 'ENTRAR',
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'LEMBRETE: SEU EMAIL E SENHA SÃO CADASTRADOS NA LOJA E SÓ CONSEGUIMOS ATUALIZAR SUA SENHA PRESENCIALMENTE',
                style:
                    TextStyle(color: Color(0XFF797777), fontFamily: fontGlobal),
                textAlign: TextAlign.center,
              ),
            ),
            const Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Color(0XFF797777),
                    thickness: 2,
                    indent: 30,
                    endIndent: 10,
                  ),
                ),
                SizedBox(
                  width: 110,
                  child: Text(
                    'USE O FACEID DO DISPOSITIVO',
                    style: TextStyle(
                        color: Color(0XFF797777), fontFamily: fontGlobal),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.grey,
                    thickness: 2,
                    indent: 10,
                    endIndent: 30,
                  ),
                ),
              ],
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
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: GradientButton(
                    onPressed: () {
                      store.getUserStorage();
                    },
                    text: 'USAR FACEID OU DIGITAL'),
              ),
          ],
        ),
      ),
    );
  }
}
