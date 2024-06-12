import 'package:cartao_acessorios/errors/errors.dart';
import 'package:cartao_acessorios/request_documents/contract/params_request.dart';
import 'package:cartao_acessorios/request_documents/contract/request_documents.dart';
import 'package:cartao_acessorios/request_documents/contract/response_request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetCartaoFirebase implements IRequestOneDocument {
  FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Future<IResponseResquest> get(IParamsRequest params) async {
    final cartao = await db
        .collection(params.collection)
        .where('userId', isEqualTo: params.where!['userId'])
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        for (var docSnapshot in querySnapshot.docs) {
          final IResponseResquest document =
              IResponseResquest(id: docSnapshot.id, data: docSnapshot.data());
          return document;
        }
      } else {
        throw DatasourceError(message: 'Erro no Firebase');
      }
    });

    if (cartao is IResponseResquest) {
      return cartao;
    } else {
      throw DatasourceError(message: 'Erro no firebase');
    }
  }
}
