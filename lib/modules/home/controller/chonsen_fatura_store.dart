import 'package:flutter/material.dart';

class ChosenFaturasStore {
  final ValueNotifier<String> fatura = ValueNotifier<String>('');

  void setFatura({required String faturaId}) {
    fatura.value = faturaId;
  }
}
