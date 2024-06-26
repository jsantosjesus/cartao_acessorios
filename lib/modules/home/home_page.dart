import 'package:cartao_acessorios/modules/home/get_faturas/presenter/list_faturas_widget.dart';
// import 'package:cartao_acessorios/modules/home/get_lancamentos/presenter/lancamentos_widget.dart';
import 'package:cartao_acessorios/modules/home/get_user_home/presenter/user_home_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String uid;
  const HomePage({super.key, required this.uid});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF1F1F1F),
      body: Column(
        children: [
          UserHomeWidget(uid: widget.uid),
          Expanded(
            child: ListFaturasWidget(
              userId: widget.uid,
            ),
          ),
        ],
      ),
    );
  }
}
