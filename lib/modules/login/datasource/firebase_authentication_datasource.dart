import 'package:cartao_acessorios/errors/errors.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthenticationDatasource {
  Future<String> authenticationEmailAndPassword(
      {required String email, required String password});
}

class FirebaseAuthenticationDatasourceImpl
    implements IAuthenticationDatasource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<String> authenticationEmailAndPassword(
      {required String email, required String password}) async {
    try {
      UserCredential usuarioAuth = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      return usuarioAuth.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential") {
        throw DatasourceError(message: 'email ou senha inválidos');
      } else {
        throw DatasourceError(message: 'Erro na autenticação');
      }
    }
  }
}
