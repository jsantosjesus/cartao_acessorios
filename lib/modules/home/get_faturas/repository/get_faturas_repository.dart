import 'package:cartao_acessorios/modules/home/get_faturas/models/fatura_model.dart';
import 'package:cartao_acessorios/request_documents/contract/params_request.dart';
import 'package:cartao_acessorios/request_documents/contract/request_documents.dart';

abstract class IGetFaturasRepository {
  Future<List<FaturaModel>> getFaturas({required String userId});
}

class GetFaturasRepositoryImpl implements IGetFaturasRepository {
  final IRequestSeveralDocuments request;

  GetFaturasRepositoryImpl({required this.request});
  @override
  Future<List<FaturaModel>> getFaturas({required String userId}) async {
    final result = await request.get(IParamsRequest(
        collection: 'usuario', document: userId, subcollection: 'fatura'));

    final List<FaturaModel> listFaturas = [];

    result.map((response) {
      listFaturas.add(FaturaModel.fromMap(map: response.data, id: response.id));
    }).toList();

    return listFaturas;
  }
}
