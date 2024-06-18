class CartaoModel {
  final String nomeImpresso;
  final double limite;
  final double limiteGasto;
  final int dataFechamento;
  final int dataVencimento;
  final String numero;

  CartaoModel(
      {required this.nomeImpresso,
      required this.limite,
      required this.limiteGasto,
      required this.dataFechamento,
      required this.dataVencimento,
      required this.numero});

  factory CartaoModel.fromMap({required Map<String, dynamic> map}) {
    return CartaoModel(
        nomeImpresso: map['nomeImpresso'] as String,
        limite: map['limite'] * 1.0,
        limiteGasto: map['limiteGasto'] * 1.0,
        dataFechamento: map['dataFechamento'].toInt(),
        dataVencimento: map['dataVencimento'].toInt(),
        numero: map['numero'] as String);
  }
}
