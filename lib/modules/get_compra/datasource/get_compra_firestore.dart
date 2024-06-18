import 'package:cartao_acessorios/errors/errors.dart';
import 'package:cartao_acessorios/request_documents/contract/params_request.dart';
import 'package:cartao_acessorios/request_documents/contract/request_documents.dart';
import 'package:cartao_acessorios/request_documents/contract/response_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetCompraFirestore implements IRequestOneDocument {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Future<IResponseResquest> get(IParamsRequest params) async {
    final docRef = db.collection(params.collection).doc(params.document);

    try {
      DocumentSnapshot doc = await docRef.get();

      if (doc.exists) {
        return IResponseResquest(
            id: doc.id, data: doc.data() as Map<String, dynamic>);
      } else {
        throw DatasourceError(message: 'Nenhum dado encontrado');
      }
    } catch (e) {
      throw DatasourceError(message: 'Erro no Firestore: ${e.toString()}');
    }
  }
}
