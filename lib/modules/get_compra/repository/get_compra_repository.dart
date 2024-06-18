import 'package:cartao_acessorios/modules/get_compra/models/compra_model.dart';
import 'package:cartao_acessorios/request_documents/contract/params_request.dart';
import 'package:cartao_acessorios/request_documents/contract/request_documents.dart';

abstract class IGetCompraRepository {
  Future<CompraModel> getCompra({required String compraId});
}

class GetCompraReposiroty implements IGetCompraRepository {
  final IRequestOneDocument request;

  GetCompraReposiroty({required this.request});
  @override
  Future<CompraModel> getCompra({required String compraId}) async {
    final result = await request
        .get(IParamsRequest(collection: 'compra', document: compraId));

    return CompraModel.fromMap(map: result.data, id: result.id);
  }
}
