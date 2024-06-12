import 'package:cartao_acessorios/modules/home/cartao_home/models/cartao_model.dart';
import 'package:cartao_acessorios/modules/home/cartao_home/repository/get_cartao_repository.dart';
import 'package:flutter/material.dart';

class CartaoHomeStore {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);

  final ValueNotifier<String> error = ValueNotifier<String>('');

  final ValueNotifier<CartaoModel> success = ValueNotifier<CartaoModel>(
    CartaoModel(
        id: '',
        userId: '',
        nomeImpresso: '',
        limite: 0,
        limiteGasto: 0,
        dataFechamento: 0,
        dataVencimento: 0),
  );

  final IGetCartaoRepository repository;

  CartaoHomeStore({required this.repository});

  Future getCartao({required String idUser}) async {
    try {
      final CartaoModel resultCartao =
          await repository.getCartao(idUser: idUser);

      success.value = resultCartao;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }
}
