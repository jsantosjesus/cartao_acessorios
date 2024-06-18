import 'package:cartao_acessorios/modules/home/get_user_home/datasource/get_user_firestore.dart';
import 'package:cartao_acessorios/modules/home/get_user_home/models/user_model.dart';
import 'package:cartao_acessorios/modules/home/get_user_home/presenter/store/get_user_home_store.dart';
import 'package:cartao_acessorios/modules/home/get_user_home/presenter/utils/numero_cartao_buffer.dart';
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
    return Padding(
      padding: const EdgeInsets.only(top: 80.0, bottom: 30.0),
      child: AnimatedBuilder(
        animation:
            Listenable.merge([store.error, store.isLoading, store.success]),
        builder: ((context, child) {
          if (store.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (store.error.value.isNotEmpty) {
            return const Center(
              child: Text(
                'Ocorreu um erro!',
                style: TextStyle(color: Colors.white),
              ),
            );
          } else {
            final UserModel user = store.success.value;
            final String numeroCartao =
                numeroCartaoBuffer(numero: user.cartao.numero);
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 20.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'É bom te ver novamente,',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.white),
                          ),
                          Text(
                            user.nome,
                            style: const TextStyle(
                                fontSize: 24.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(width: 130.0),
                      CircleAvatar(
                        backgroundImage: NetworkImage(user.img),
                        radius: 28,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 370,
                  height: 200,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFFF6A8),
                        Color(0xFF8D7B18),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      transform: GradientRotation(
                        135 * (3.1415926535897932 / 180),
                      ),
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20, left: 20),
                        child: Text('Limite disponível:'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 180),
                        child: Text(
                            'R\$ ${(user.cartao.limite - user.cartao.limiteGasto).toStringAsFixed(2).replaceAll('.', ',')} de R\$ ${(user.cartao.limite).toStringAsFixed(2).replaceAll('.', ',')}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: LinearProgressIndicator(
                          value: user.cartao.limiteGasto / user.cartao.limite,
                          minHeight: 10,
                          color: const Color(0XFF1F1F1F),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 35, left: 20),
                        child: Text(
                          numeroCartao,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12, left: 20),
                        child: Text(
                          user.cartao.nomeImpresso,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
