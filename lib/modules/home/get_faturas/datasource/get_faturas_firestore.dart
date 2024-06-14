import 'package:cartao_acessorios/errors/errors.dart';
import 'package:cartao_acessorios/request_documents/contract/params_request.dart';
import 'package:cartao_acessorios/request_documents/contract/request_documents.dart';
import 'package:cartao_acessorios/request_documents/contract/response_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetFaturasFirestore implements IRequestSeveralDocuments {
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Future<List<IResponseResquest>> get(IParamsRequest params) async {
    try {
      final docRef = await db
          .collection(params.collection)
          .doc(params.document)
          .collection(params.subcollection!)
          .get();

      final List<IResponseResquest> listFaturas = [];
      for (var docSnapshot in docRef.docs) {
        final IResponseResquest fatura =
            IResponseResquest(id: docSnapshot.id, data: docSnapshot.data());
        listFaturas.add(fatura);
      }

      if (listFaturas.isNotEmpty) {
        return listFaturas;
      } else {
        throw DatasourceError(message: 'lista vazia');
      }
    } catch (e) {
      throw DatasourceError(message: e.toString());
    }
  }
}
