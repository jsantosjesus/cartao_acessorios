import 'package:cartao_acessorios/modules/home/get_user_home/datasource/get_user_firestore.dart';
import 'package:cartao_acessorios/modules/home/get_user_home/presenter/store/get_user_home_store.dart';
import 'package:cartao_acessorios/modules/home/get_user_home/repository/get_user_repository.dart';
import 'package:flutter/material.dart';

class UserHomeWidget extends StatefulWidget {
  final String uid;
  const UserHomeWidget({super.key, required this.uid});

  @override
  State<UserHomeWidget> createState() => _UserHomeWidgetState();
}

class _UserHomeWidgetState extends State<UserHomeWidget> {
  final GetUserHomeStore store = GetUserHomeStore(
      repository: GetUserRepository(request: GetUserFirestore()));

  @override
  void initState() {
    super.initState();

    store.getUser(uid: widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation:
          Listenable.merge([store.error, store.isLoading, store.success]),
      builder: ((context, child) {
        if (store.isLoading.value) {
          return AppBar(
            title: const CircularProgressIndicator(),
          );
        } else if (store.error.value.isNotEmpty) {
          return AppBar(
            title: const Text('Ocorreu um erro!'),
          );
        } else {
          return AppBar(
            leading: const Padding(
              padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://avatars.githubusercontent.com/u/122129093?v=4'),
              ),
            ),
            title: Text('Olá, ${store.success.value.nome}'),
            titleTextStyle:
                const TextStyle(fontSize: 20.0, color: Colors.black),
          );
        }
      }),
    );
  }
}
