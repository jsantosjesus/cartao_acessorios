import 'package:cartao_acessorios/global_styles_config/styles_global.dart';
import 'package:cartao_acessorios/modules/home/get_faturas/models/fatura_model.dart';
import 'package:cartao_acessorios/modules/home/get_lancamentos/presenter/utils/rewrite_date_lancamento.dart';
import 'package:flutter/material.dart';
import 'package:cartao_acessorios/modules/home/get_lancamentos/datasource/get_lancamentos_firestore.dart';
import 'package:cartao_acessorios/modules/home/get_lancamentos/presenter/store/lancamentos_store.dart';
import 'package:cartao_acessorios/modules/home/get_lancamentos/repository/get_lancamentos_repository.dart';
import 'package:go_router/go_router.dart';

class LancamentosWidget extends StatefulWidget {
  final ValueNotifier<FaturaModel> faturaNotifier;
  const LancamentosWidget({super.key, required this.faturaNotifier});

  @override
  State<LancamentosWidget> createState() => _LancamentosWidgetState();
}

class _LancamentosWidgetState extends State<LancamentosWidget> {
  late LancamentosStore store;
  late double total;

  @override
  void initState() {
    super.initState();
    store = LancamentosStore(
      repository: GetLancamentosRepository(
        request: GetLancamentosFirestore(),
      ),
    );

    widget.faturaNotifier.addListener(_updateLancamentos);
    _updateLancamentos();
  }

  @override
  void dispose() {
    widget.faturaNotifier.removeListener(_updateLancamentos);
    super.dispose();
  }

  void _updateLancamentos() {
    store.getLancamentos(faturaId: widget.faturaNotifier.value.id);
    setState(() {
      total = widget.faturaNotifier.value.total;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AnimatedBuilder(
            animation: Listenable.merge([
              store.isLoading,
              store.success,
              store.error,
            ]),
            builder: ((context, child) {
              if (store.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              } else if (store.error.value.isNotEmpty) {
                return Center(
                  child: Text(
                    store.error.value,
                    style: const TextStyle(fontFamily: fontGlobal),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: store.success.value.length,
                  itemBuilder: (_, id) {
                    final lancamento = store.success.value[id];
                    final data = rewriteDateLancamento(data: lancamento.data);
                    return ListTile(
                      onTap: () {
                        if (lancamento.compraId != null) {
                          context.push('/compra/${lancamento.compraId}');
                        }
                      },
                      leading: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3B3B3B),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          lancamento.isDebito ? Icons.shop_two : Icons.payment,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        lancamento.descricao,
                        style: const TextStyle(
                            color: Colors.white, fontFamily: fontGlobal),
                      ),
                      subtitle: Text(
                        data,
                        style: const TextStyle(
                            color: Color(0xFF8A8A8A), fontFamily: fontGlobal),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'R\$ ${lancamento.valor.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: lancamento.isDebito
                                    ? Colors.red
                                    : Colors.green,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                fontFamily: fontGlobal),
                          ),
                          if (lancamento.parcela != null)
                            Text(
                              'Parcela ${lancamento.parcela!}',
                              style: const TextStyle(fontFamily: fontGlobal),
                            )
                        ],
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ),
        Container(
          // height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          // width: 300,
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80.0),
              color: const Color(0XFF3B3B3B)),
          child: Text(
            'TOTAL DA FATURA: R\$ ${(total).toStringAsFixed(2).replaceAll('.', ',')}',
            style: const TextStyle(
                color: Colors.white, fontFamily: fontGlobal, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
