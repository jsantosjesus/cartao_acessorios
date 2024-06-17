import 'package:cartao_acessorios/modules/home/get_lancamentos/models/lancamento_model.dart';
import 'package:cartao_acessorios/request_documents/contract/params_request.dart';
import 'package:cartao_acessorios/request_documents/contract/request_documents.dart';

abstract class IGetLancamentosRepository {
  Future<List<LancamentoModel>> getLancamento({required String faturaId});
}

class GetLancamentosRepository implements IGetLancamentosRepository {
  final IRequestSeveralDocuments request;

  GetLancamentosRepository({required this.request});
  @override
  Future<List<LancamentoModel>> getLancamento(
      {required String faturaId}) async {
    List<LancamentoModel> listLancamentos = [];

    final result = await request.get(
      IParamsRequest(collection: 'lancamento', where: {'faturaId': faturaId}),
    );
    // print(result.length);

    result.map((lancamento) {
      LancamentoModel lancamentoModel =
          LancamentoModel.fromMap(map: lancamento.data, id: lancamento.id);
      // print('está rodando o map');
      listLancamentos.add(lancamentoModel);
    }).toList();
    // print(listLancamentos.length);

    return listLancamentos;
  }
}
