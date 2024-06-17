import 'package:cloud_firestore/cloud_firestore.dart';

class LancamentoModel {
  final String id;
  final String faturaId;
  final String? compraId;
  final String descricao;
  final DateTime data;
  final double valor;
  final bool isDebito;

  LancamentoModel(
      {required this.id,
      required this.faturaId,
      this.compraId,
      required this.descricao,
      required this.data,
      required this.valor,
      required this.isDebito});

  factory LancamentoModel.fromMap(
      {required Map<String, dynamic> map, required String id}) {
    final Timestamp timestampData = map['data'];
    return LancamentoModel(
      id: id,
      faturaId: map['faturaId'] as String,
      // compraId: map['compraId'] != null ? map['compraId'] as String : null,
      descricao: map['descricao'] as String,
      data: timestampData.toDate(),
      valor: map['valor'] * 1.0,
      isDebito: map['isDebito'] as bool,
    );
  }
}
