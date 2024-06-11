import 'package:cartao_acessorios/request_documents/contract/params_request.dart';
import 'package:cartao_acessorios/request_documents/contract/response_request.dart';

abstract class IRequestOneDocument {
  Future<IResponseResquest> get(IParamsRequest params);
}

abstract class IRequestSeveralDocuments {
  Future<List<IResponseResquest>> get(IParamsRequest params);
}
