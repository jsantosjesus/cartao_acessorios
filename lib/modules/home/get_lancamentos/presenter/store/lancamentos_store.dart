import 'package:cartao_acessorios/errors/errors.dart';
import 'package:cartao_acessorios/modules/home/get_lancamentos/models/lancamento_model.dart';
import 'package:cartao_acessorios/modules/home/get_lancamentos/repository/get_lancamentos_repository.dart';
import 'package:flutter/material.dart';

class LancamentosStore {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<String> error = ValueNotifier<String>('');

  final ValueNotifier<List<LancamentoModel>> success =
      ValueNotifier<List<LancamentoModel>>([]);

  final IGetLancamentosRepository repository;

  LancamentosStore({required this.repository});

  Future getLancamentos({required String faturaId}) async {
    isLoading.value = true;
    try {
      final result = await repository.getLancamento(faturaId: faturaId);

      success.value = result;
      print(success.value[0].descricao);
    } on DatasourceError catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
      print(e.toString());
    }

    isLoading.value = false;
  }
}
