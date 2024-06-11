import 'package:cartao_acessorios/modules/login/utils/salve_storage/contract/usuario_storage_model.dart';

abstract class IStorageUser {
  Future<UserStorageModel> getUserStorage();

  Future setUserStorage({required String email, required String password});

  Future removeUserStorage();
}
