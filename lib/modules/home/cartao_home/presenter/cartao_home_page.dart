import 'package:cartao_acessorios/modules/home/cartao_home/datasource/get_cartao_firebase.dart';
import 'package:cartao_acessorios/modules/home/cartao_home/presenter/store/cartao_home_store.dart';
import 'package:cartao_acessorios/modules/home/cartao_home/repository/get_cartao_repository.dart';
import 'package:flutter/material.dart';

class CartaoHomePage extends StatefulWidget {
  final String idUser;
  const CartaoHomePage({super.key, required this.idUser});

  @override
  State<CartaoHomePage> createState() => _CartaoHomePageState();
}

class _CartaoHomePageState extends State<CartaoHomePage> {
  final CartaoHomeStore store = CartaoHomeStore(
    repository: GetCartaoRepository(
      request: GetCartaoFirebase(),
    ),
  );

  @override
  void initState() {
    super.initState();

    store.getCartao(idUser: widget.idUser);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        store.isLoading,
        store.error,
        store.success,
      ]),
      builder: ((context, child) {
        if (store.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (store.error.value.isNotEmpty) {
          return const Center(
            child: Text('Acontecu um erro'),
          );
        } else {
          return Container(
            child: Center(
              child: Text(store.success.value.nomeImpresso),
            ),
          );
        }
      }),
    );
  }
}
