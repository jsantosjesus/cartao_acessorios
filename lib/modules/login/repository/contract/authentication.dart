abstract class IAuthenticationRepository {
  Future<String> authEmailAndPassword(
      {required String email, required String password});
}
