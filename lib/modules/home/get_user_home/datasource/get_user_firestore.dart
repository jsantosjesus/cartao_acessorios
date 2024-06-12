import 'package:cartao_acessorios/errors/errors.dart';
import 'package:cartao_acessorios/request_documents/contract/params_request.dart';
import 'package:cartao_acessorios/request_documents/contract/request_documents.dart';
import 'package:cartao_acessorios/request_documents/contract/response_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetUserFirestore implements IRequestOneDocument {
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Future<IResponseResquest> get(IParamsRequest params) async {
    final docRef = db.collection(params.collection).doc(params.document);

    try {
      DocumentSnapshot doc = await docRef.get();

      if (doc.exists) {
        final IResponseResquest document = IResponseResquest(
            id: doc.id, data: doc.data() as Map<String, dynamic>);
        return document;
      } else {
        throw DatasourceError(
            message: 'Requisição ao firebase deu certo, mas não tem dado');
      }
    } catch (e) {
      throw DatasourceError(message: 'Erro no firebase: ${e.toString()}');
    }
  }
}
