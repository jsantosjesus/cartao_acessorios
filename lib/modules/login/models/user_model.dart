class UserModel {
  final String uid;
  final String nome;
  final String cpf;
  final String email;
  final String telefone;

  UserModel(
      {required this.uid,
      required this.nome,
      required this.cpf,
      required this.email,
      required this.telefone});

  factory UserModel.fromMap(
      {required String id, required Map<String, dynamic> map}) {
    return UserModel(
      uid: id,
      nome: map['nome'] as String,
      cpf: map['cpf'] as String,
      email: map['email'] as String,
      telefone: map['telefone'] as String,
    );
  }
}
