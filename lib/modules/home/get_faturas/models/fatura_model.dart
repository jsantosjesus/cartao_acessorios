import 'package:cloud_firestore/cloud_firestore.dart';

class FaturaModel {
  final String id;
  final DateTime dataVencimento;
  final DateTime dataFechamento;
  final double total;

  FaturaModel(
      {required this.id,
      required this.dataVencimento,
      required this.dataFechamento,
      required this.total});

  factory FaturaModel.fromMap(
      {required Map<String, dynamic> map, required String id}) {
    final Timestamp timestampVencimento = map['dataVencimento'];
    final Timestamp timestampFechamento = map['dataFechamento'];
    return FaturaModel(
      id: id,
      dataVencimento: timestampVencimento.toDate(),
      dataFechamento: timestampFechamento.toDate(),
      total: map['total'] * 1.0,
    );
  }
}
