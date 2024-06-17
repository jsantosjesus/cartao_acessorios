import 'package:cartao_acessorios/modules/home/controller/chonsen_fatura_store.dart';
import 'package:flutter/material.dart';
import 'package:cartao_acessorios/modules/home/get_faturas/datasource/get_faturas_firestore.dart';
import 'package:cartao_acessorios/modules/home/get_faturas/presenter/store/get_faturas_store.dart';
import 'package:cartao_acessorios/modules/home/get_faturas/presenter/utils/change_mes_int_for_mes_string.dart';
import 'package:cartao_acessorios/modules/home/get_faturas/repository/get_faturas_repository.dart';
import 'package:cartao_acessorios/modules/home/get_lancamentos/presenter/lancamentos_widget.dart';

class ListFaturasWidget extends StatefulWidget {
  final String userId;
  const ListFaturasWidget({super.key, required this.userId});

  @override
  State<ListFaturasWidget> createState() => _ListFaturasWidgetState();
}

class _ListFaturasWidgetState extends State<ListFaturasWidget> {
  final GetFaturasStore store = GetFaturasStore(
    repository: GetFaturasRepositoryImpl(request: GetFaturasFirestore()),
  );

  final ChosenFaturasStore faturaChosen = ChosenFaturasStore();
  bool hasIdFatura = false;

  @override
  void initState() {
    super.initState();

    store.getFaturas(userId: widget.userId).then((_) {
      if (faturaChosen.fatura.value.isEmpty) {
        final mesAgora = DateTime.now().month;
        final faturadoMes = store.success.value.firstWhere(
          (map) => map.dataVencimento.month == mesAgora,
        );
        setState(() {
          faturaChosen.setFatura(faturaId: faturadoMes.id);

          hasIdFatura = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: Listenable.merge(
            [store.error, store.isLoading, store.success, faturaChosen.fatura],
          ),
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
                      ano: fatura.dataVencimento.year,
                    );
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GestureDetector(
                        onTap: () {
                          faturaChosen.setFatura(faturaId: fatura.id);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: faturaChosen.fatura.value == fatura.id
                                    ? Colors.black
                                    : Colors.transparent,
                                width: 3.0,
                              ),
                            ),
                          ),
                          child: Center(child: Text(mes)),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          }),
        ),
        if (hasIdFatura)
          Expanded(
            child: LancamentosWidget(
              faturaNotifier: faturaChosen.fatura,
            ),
          ),
      ],
    );
  }
}
