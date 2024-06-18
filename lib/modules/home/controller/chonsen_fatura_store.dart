import 'package:cartao_acessorios/modules/home/get_faturas/models/fatura_model.dart';
import 'package:flutter/material.dart';

class ChosenFaturasStore {
  final ValueNotifier<FaturaModel> fatura = ValueNotifier<FaturaModel>(
      FaturaModel(
          id: '',
          dataVencimento: DateTime(0),
          dataFechamento: DateTime(0),
          total: 0));

  void setFatura({required FaturaModel faturaId}) {
    fatura.value = faturaId;
  }
}
