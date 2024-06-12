// import 'package:cartao_acessorios/errors/errors.dart';
// import 'package:cartao_acessorios/request_documents/contract/params_request.dart';
// import 'package:cartao_acessorios/request_documents/contract/request_documents.dart';
// import 'package:cartao_acessorios/request_documents/contract/response_request.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class FirestoreRequestUser implements IRequestOneDocument {
//   FirebaseFirestore db = FirebaseFirestore.instance;
//   @override
//   Future<IResponseResquest> get(IParamsRequest params) async {
//     final docRef = await db
//         .collection(params.collection)
//         .where('cpf', isEqualTo: params.where)
//         .get()
//         .then((querySnapshot) {
//       if (querySnapshot.docs.isNotEmpty) {
//         for (var docSnapshot in querySnapshot.docs) {
//           final IResponseResquest document =
//               IResponseResquest(id: docSnapshot.id, data: docSnapshot.data());
//           return document;
//         }
//       } else {
//         throw DatasourceError(
//             message:
//                 'Desculpe, seu CPF não está cadastrado em nosso banco! Fale com o nosso financeiro: (79) 9 9999-9999');
//       }
//     });

//     if (docRef is IResponseResquest) {
//       return docRef;
//     } else {
//       throw DatasourceError(message: 'Erro no firebase');
//     }
//   }
// }
