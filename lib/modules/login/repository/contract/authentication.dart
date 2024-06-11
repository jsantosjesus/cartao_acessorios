import 'package:cartao_acessorios/modules/login/models/user_model.dart';

abstract class IAuthenticationRepository {
  Future<UserModel> authEmailAndPassword(
      {required String email, required String password});
}
