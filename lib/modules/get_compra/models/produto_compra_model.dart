class ProdutoCompraModel {
  final String nome;
  final int quantidade;
  final double valor;

  ProdutoCompraModel(
      {required this.nome, required this.quantidade, required this.valor});

  factory ProdutoCompraModel.fromMap(Map<String, dynamic> map) {
    return ProdutoCompraModel(
      nome: map['nome'] as String,
      quantidade: map['quantidade'] as int,
      valor: map['valor'] * 1.0,
    );
  }
}
