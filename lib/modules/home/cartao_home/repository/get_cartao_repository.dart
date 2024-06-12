import 'package:cartao_acessorios/errors/errors.dart';
import 'package:cartao_acessorios/modules/home/cartao_home/models/cartao_model.dart';
import 'package:cartao_acessorios/request_documents/contract/params_request.dart';
import 'package:cartao_acessorios/request_documents/contract/request_documents.dart';

abstract class IGetCartaoRepository {
  Future<CartaoModel> getCartao({required String idUser});
}

class GetCartaoRepository implements IGetCartaoRepository {
  final IRequestOneDocument request;

  GetCartaoRepository({required this.request});
  @override
  Future<CartaoModel> getCartao({required String idUser}) async {
    final cartao = await request
        .get(IParamsRequest(collection: 'cartao', where: {'idUser': idUser}));

    if (cartao.id.isNotEmpty) {
      final CartaoModel cartaoModel =
          CartaoModel.fromMap(map: cartao.data, id: cartao.id);

      print(cartaoModel.dataVencimento);
      return CartaoModel.fromMap(map: cartao.data, id: cartao.id);
    } else {
      throw RepositoryError(message: 'Erro no repositório');
    }
  }
}
