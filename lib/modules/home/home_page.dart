// import 'package:cartao_acessorios/modules/home/cartao_home/datasource/get_cartao_firebase.dart';
// import 'package:cartao_acessorios/modules/home/cartao_home/repository/get_cartao_repository.dart';
import 'package:cartao_acessorios/modules/home/cartao_home/presenter/cartao_home_page.dart';
import 'package:cartao_acessorios/modules/home/get_user_home/presenter/user_home_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String uid;
  const HomePage({super.key, required this.uid});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // testes
  // teste get cartao

  // final IGetCartaoRepository repositoryCartao =
  //     GetCartaoRepository(request: GetCartaoFirebase());

  // @override
  // void initState() {
  //   super.initState();

  //   repositoryCartao.getCartao(idUser: widget.uid);
  // }

  //fim do teste

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UserHomeWidget(uid: widget.uid),
          CartaoHomePage(idUser: widget.uid),
        ],
      ),
    );
  }
}
