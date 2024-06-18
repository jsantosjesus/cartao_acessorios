import 'package:cartao_acessorios/modules/get_compra/models/produto_compra_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CompraModel {
  final String id;
  final DateTime data;
  final String observacao;
  final int quantidadeParcelas;
  final double total;
  final List<ProdutoCompraModel> produtos;

  CompraModel(
      {required this.id,
      required this.data,
      required this.observacao,
      required this.quantidadeParcelas,
      required this.total,
      required this.produtos});

  factory CompraModel.fromMap(
      {required Map<String, dynamic> map, required String id}) {
    final Timestamp timestampData = map['data'];

    final List<dynamic> listData = map['produtos'];
    final List<ProdutoCompraModel> listProdutos = [];

    listData.map((prod) {
      listProdutos.add(ProdutoCompraModel.fromMap(prod));
    }).toList();

    return CompraModel(
        id: id,
        data: timestampData.toDate(),
        observacao: map['observacao'] as String,
        quantidadeParcelas: map['quantidadeParcelas'] as int,
        total: map['total'] * 1.0,
        produtos: listProdutos);
  }
}
