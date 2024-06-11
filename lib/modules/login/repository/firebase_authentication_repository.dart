import 'package:cartao_acessorios/errors/errors.dart';
import 'package:cartao_acessorios/modules/login/datasource/firebase_authentication_datasource.dart';
import 'package:cartao_acessorios/modules/login/repository/contract/authentication.dart';

class FirebaseAuthenticationRepository implements IAuthenticationRepository {
  final IAuthenticationDatasource datasource;

  FirebaseAuthenticationRepository({required this.datasource});

  @override
  Future<String> authEmailAndPassword(
      {required String email, required String password}) async {
    final String uid = await datasource.authenticationEmailAndPassword(
        email: email, password: password);

    if (uid.isNotEmpty) {
      return uid;
    } else {
      throw RepositoryError(message: 'erro ao fazer requisição');
    }
  }
}
