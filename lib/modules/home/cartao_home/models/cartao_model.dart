class CartaoModel {
  final String id;
  final String userId;
  final String nomeImpresso;
  final double limite;
  final double limiteGasto;
  final int dataFechamento;
  final int dataVencimento;

  CartaoModel(
      {required this.id,
      required this.userId,
      required this.nomeImpresso,
      required this.limite,
      required this.limiteGasto,
      required this.dataFechamento,
      required this.dataVencimento});

  factory CartaoModel.fromMap(
      {required Map<String, dynamic> map, required String id}) {
    return CartaoModel(
      id: id,
      userId: map['userId'] as String,
      nomeImpresso: map['nomeImpresso'] as String,
      limite: map['limite'] * 1.0,
      limiteGasto: map['limiteGasto'] * 1.0,
      dataFechamento: map['dataFechamento'].toInt(),
      dataVencimento: map['dataVencimento'].toInt(),
    );
  }
}
