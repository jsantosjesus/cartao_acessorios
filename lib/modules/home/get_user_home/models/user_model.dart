import 'package:cartao_acessorios/modules/home/get_user_home/models/cartao_model.dart';

class UserModel {
  final String uid;
  final String img;
  final String nome;
  final String cpf;
  final String email;
  final String telefone;
  final CartaoModel cartao;

  UserModel({
    required this.uid,
    required this.img,
    required this.nome,
    required this.cpf,
    required this.email,
    required this.telefone,
    required this.cartao,
  });

  factory UserModel.fromMap(
      {required String id, required Map<String, dynamic> map}) {
    return UserModel(
      uid: id,
      img: map['img'] as String,
      nome: map['nome'] as String,
      cpf: map['cpf'] as String,
      email: map['email'] as String,
      telefone: map['telefone'] as String,
      cartao: CartaoModel.fromMap(map: map['cartao']),
    );
  }
}
