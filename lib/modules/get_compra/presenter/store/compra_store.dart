import 'package:cartao_acessorios/errors/errors.dart';
import 'package:cartao_acessorios/modules/get_compra/models/compra_model.dart';
import 'package:cartao_acessorios/modules/get_compra/repository/get_compra_repository.dart';
import 'package:flutter/material.dart';

class CompraStore {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);

  final ValueNotifier<String> error = ValueNotifier<String>('');

  final ValueNotifier<CompraModel> success = ValueNotifier<CompraModel>(
      CompraModel(
          id: '',
          data: DateTime(0),
          observacao: '',
          quantidadeParcelas: 0,
          total: 0,
          produtos: []));

  final GetCompraReposiroty repository;

  CompraStore({required this.repository});

  Future getCompra({required String compraId}) async {
    try {
      final result = await repository.getCompra(compraId: compraId);

      success.value = result;
      print(success.value.observacao);
    } on DatasourceError catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }

    print(error.value);
    isLoading.value = false;
  }
}
