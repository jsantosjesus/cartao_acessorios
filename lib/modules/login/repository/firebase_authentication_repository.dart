import 'package:cartao_acessorios/errors/errors.dart';
import 'package:cartao_acessorios/modules/login/datasource/firebase_authentication_datasource.dart';
import 'package:cartao_acessorios/modules/login/models/user_model.dart';
import 'package:cartao_acessorios/modules/login/repository/contract/authentication.dart';
import 'package:cartao_acessorios/modules/login/repository/get_user_repository.dart';

class FirebaseAuthenticationRepository implements IAuthenticationRepository {
  final IAuthenticationDatasource datasource;
  final IGetUserRepository getUserRespository;

  FirebaseAuthenticationRepository(
      {required this.datasource, required this.getUserRespository});

  @override
  Future<UserModel> authEmailAndPassword(
      {required String email, required String password}) async {
    final String uid = await datasource.authenticationEmailAndPassword(
        email: email, password: password);

    if (uid.isNotEmpty) {
      final UserModel result = await getUserRespository.getUser(uid: uid);

      return result;
    } else {
      throw RepositoryError(message: 'erro ao fazer requisição');
    }
  }
}
