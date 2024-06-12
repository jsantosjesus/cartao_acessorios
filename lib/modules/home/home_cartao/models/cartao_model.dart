class CartaoModel {
  final String id;
  final String nomeImpresso;
  final double limite;
  final String dataFechamento;
  final String dataVencimento;

  CartaoModel(
      {required this.id,
      required this.nomeImpresso,
      required this.limite,
      required this.dataFechamento,
      required this.dataVencimento});

  factory CartaoModel.fromMap(Map<String, dynamic> map) {
    return CartaoModel(
      id: map['id'] as String,
      nomeImpresso: map['nomeImpresso'] as String,
      limite: map['limite'] as double,
      dataFechamento: map['dataFechamento'] as String,
      dataVencimento: map['dataVencimento'] as String,
    );
  }
}
