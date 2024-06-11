import 'package:cartao_acessorios/errors/errors.dart';
import 'package:cartao_acessorios/modules/login/models/user_model.dart';
import 'package:cartao_acessorios/request_documents/contract/params_request.dart';
import 'package:cartao_acessorios/request_documents/contract/request_documents.dart';

abstract class IGetUserRepository {
  Future<UserModel> getUser({required String uid});
}

class GetUserRepository implements IGetUserRepository {
  final IRequestOneDocument request;

  GetUserRepository({required this.request});
  @override
  Future<UserModel> getUser({required String uid}) async {
    final user =
        await request.get(IParamsRequest(collection: 'usuario', document: uid));

    if (user.id.isNotEmpty) {
      return UserModel.fromMap(id: user.id, map: user.data);
    } else {
      throw RepositoryError(message: 'Erro no repositório');
    }
  }
}
