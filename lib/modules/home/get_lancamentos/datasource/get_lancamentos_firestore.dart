import 'package:cartao_acessorios/errors/errors.dart';
import 'package:cartao_acessorios/request_documents/contract/params_request.dart';
import 'package:cartao_acessorios/request_documents/contract/request_documents.dart';
import 'package:cartao_acessorios/request_documents/contract/response_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetLancamentosFirestore implements IRequestSeveralDocuments {
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Future<List<IResponseResquest>> get(IParamsRequest params) async {
    try {
      final docRef = await db
          .collection(params.collection)
          .where('faturaId', isEqualTo: params.where!['faturaId'])
          .get();

      final List<IResponseResquest> listLancamentos = [];
      for (var docSnapshot in docRef.docs) {
        // print(docSnapshot.data());
        final IResponseResquest lancamento =
            IResponseResquest(id: docSnapshot.id, data: docSnapshot.data());
        listLancamentos.add(lancamento);
      }

      if (listLancamentos.isNotEmpty) {
        // print(listLancamentos[0].id);
        return listLancamentos;
      } else {
        throw DatasourceError(message: 'lista vazia');
      }
    } catch (e) {
      print(e.toString());
      throw DatasourceError(message: e.toString());
    }
  }
}
