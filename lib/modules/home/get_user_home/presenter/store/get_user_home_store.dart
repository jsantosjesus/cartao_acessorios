import 'package:cartao_acessorios/modules/home/get_user_home/models/cartao_model.dart';
import 'package:cartao_acessorios/modules/home/get_user_home/models/user_model.dart';
import 'package:cartao_acessorios/modules/home/get_user_home/repository/get_user_repository.dart';
import 'package:flutter/material.dart';

class GetUserHomeStore {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);

  final ValueNotifier<String> error = ValueNotifier<String>('');

  final ValueNotifier<UserModel> success = ValueNotifier<UserModel>(
    UserModel(
      uid: '',
      img: '',
      nome: '',
      cpf: '',
      email: '',
      telefone: '',
      cartao: CartaoModel(
          nomeImpresso: '',
          limite: 0,
          limiteGasto: 0,
          dataFechamento: 0,
          dataVencimento: 0,
          numero: ''),
    ),
  );

  final IGetUserRepository repository;

  GetUserHomeStore({required this.repository});

  Future getUser({required String uid}) async {
    try {
      final result = await repository.getUser(uid: uid);

      success.value = result;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }
}
