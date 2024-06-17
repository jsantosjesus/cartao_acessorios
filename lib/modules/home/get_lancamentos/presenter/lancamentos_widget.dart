import 'package:flutter/material.dart';
import 'package:cartao_acessorios/modules/home/get_lancamentos/datasource/get_lancamentos_firestore.dart';
import 'package:cartao_acessorios/modules/home/get_lancamentos/presenter/store/lancamentos_store.dart';
import 'package:cartao_acessorios/modules/home/get_lancamentos/repository/get_lancamentos_repository.dart';

class LancamentosWidget extends StatefulWidget {
  final ValueNotifier<String> faturaNotifier;
  const LancamentosWidget({super.key, required this.faturaNotifier});

  @override
  State<LancamentosWidget> createState() => _LancamentosWidgetState();
}

class _LancamentosWidgetState extends State<LancamentosWidget> {
  late LancamentosStore store;

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
    store.getLancamentos(faturaId: widget.faturaNotifier.value);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        store.isLoading,
        store.success,
        store.error,
      ]),
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
          return ListView.builder(
            itemCount: store.success.value.length,
            itemBuilder: (_, id) {
              final lancamento = store.success.value[id];
              return ListTile(
                leading: CircleAvatar(
                  child: Text(lancamento.descricao[0]),
                ),
                title: Text(lancamento.descricao),
              );
            },
          );
        }
      }),
    );
  }
}
