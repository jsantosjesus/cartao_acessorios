import 'package:cartao_acessorios/modules/home/controller/chonsen_fatura_store.dart';
import 'package:cartao_acessorios/modules/home/get_faturas/datasource/get_faturas_firestore.dart';
import 'package:cartao_acessorios/modules/home/get_faturas/presenter/store/get_faturas_store.dart';
import 'package:cartao_acessorios/modules/home/get_faturas/presenter/utils/change_mes_int_for_mes_string.dart';
import 'package:cartao_acessorios/modules/home/get_faturas/repository/get_faturas_repository.dart';
import 'package:flutter/material.dart';

class ListFaturasWidget extends StatefulWidget {
  final String userId;
  const ListFaturasWidget({super.key, required this.userId});

  @override
  State<ListFaturasWidget> createState() => _ListFaturasWidgetState();
}

class _ListFaturasWidgetState extends State<ListFaturasWidget> {
  final GetFaturasStore store = GetFaturasStore(
      repository: GetFaturasRepositoryImpl(request: GetFaturasFirestore()));

  final ChosenFaturasStore faturaChosen = ChosenFaturasStore();

  @override
  void initState() {
    super.initState();

    store.getFaturas(userId: widget.userId).then((_) {
      if (faturaChosen.fatura.value.isEmpty) {
        final mesAgora = DateTime.now().month;
        final faturadoMes = store.success.value
            .firstWhere((map) => map.dataVencimento.month == mesAgora);
        faturaChosen.setFatura(faturaId: faturadoMes.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(
          [store.error, store.isLoading, store.success, faturaChosen.fatura]),
      builder: ((context, child) {
        if (store.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (store.error.value.isNotEmpty) {
          return Center(
            child: Text(store.error.value),
          );
        } else {
          return SizedBox(
            height: 50.0,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: store.success.value.length,
                itemBuilder: (_, id) {
                  final fatura = store.success.value[id];
                  final mes = changeMounth(
                      mes: fatura.dataVencimento.month,
                      ano: fatura.dataVencimento.year);
                  // print(faturaChosen.fatura.value);
                  if (faturaChosen.fatura.value == fatura.id) {
                    // print(faturaChosen.fatura.value);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          faturaChosen.setFatura(faturaId: fatura.id);
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(color: Colors.black, width: 3.0),
                            ),
                          ),
                          child: Center(child: Text(mes)),
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          faturaChosen.setFatura(faturaId: fatura.id);
                        },
                        child: SizedBox(
                          child: Center(child: Text(mes)),
                        ),
                      ),
                    );
                  }
                }),
          );
        }
      }),
    );
  }
}
