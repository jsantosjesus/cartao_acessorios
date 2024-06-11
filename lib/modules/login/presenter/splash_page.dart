import 'package:cartao_acessorios/modules/login/datasource/firebase_authentication_datasource.dart';
import 'package:cartao_acessorios/modules/login/presenter/store/splash_store.dart';
import 'package:cartao_acessorios/modules/login/repository/firebase_authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashStore store = SplashStore(
      authentication: FirebaseAuthenticationRepository(
          datasource: FirebaseAuthenticationDatasourceImpl()));

  // @override
  // void initState() {
  //   super.initState();

  // }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        store.error,
        store.isLoading,
        store.success,
      ]),
      builder: (context, child) {
        if (store.isLoading.value) {
          return Container(
            color: Colors.black26,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Column(
                  children: [
                    const CircularProgressIndicator(
                      color: Colors.yellowAccent,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        store.getUserShared();
                      },
                      child: const Text('usar faceId'),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (store.error.value.isNotEmpty) {
          Future.delayed(
            Duration.zero,
            () {
              context.go('/login');
            },
          );
          return Container();
        } else {
          Future.delayed(
            Duration.zero,
            () {
              context.go('/home');
            },
          );
          return Container();
        }
      },
    );
  }
}
