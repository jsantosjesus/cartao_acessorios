import 'package:cartao_acessorios/errors/errors.dart';
import 'package:cartao_acessorios/modules/home/controller/chonsen_fatura_store.dart';
import 'package:cartao_acessorios/modules/home/get_faturas/models/fatura_model.dart';
import 'package:cartao_acessorios/modules/home/get_faturas/repository/get_faturas_repository.dart';
import 'package:flutter/material.dart';

class GetFaturasStore {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);

  final ValueNotifier<String> error = ValueNotifier<String>('');

  final ValueNotifier<List<FaturaModel>> success =
      ValueNotifier<List<FaturaModel>>([]);

  final ChosenFaturasStore faturaChosen = ChosenFaturasStore();

  final IGetFaturasRepository repository;

  GetFaturasStore({required this.repository});

  Future getFaturas({required String userId}) async {
    try {
      final result = await repository.getFaturas(userId: userId);

      if (faturaChosen.fatura.value.isEmpty) {
        print('está vazio');
        final int mesAgora = DateTime.now().month;

        FaturaModel faturadoMes =
            result.firstWhere((map) => map.dataVencimento.month == mesAgora);

        faturaChosen.setFatura(faturaId: faturadoMes.id);
        print(faturaChosen.fatura.value);
      }

      success.value = result;
    } on DatasourceError catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }

    isLoading.value = false;
  }
}
