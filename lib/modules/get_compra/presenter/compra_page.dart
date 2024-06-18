import 'package:cartao_acessorios/global_styles_config/styles_global.dart';
import 'package:cartao_acessorios/modules/get_compra/datasource/get_compra_firestore.dart';
import 'package:cartao_acessorios/modules/get_compra/presenter/store/compra_store.dart';
import 'package:cartao_acessorios/modules/get_compra/repository/get_compra_repository.dart';
import 'package:cartao_acessorios/modules/home/get_lancamentos/presenter/utils/rewrite_date_lancamento.dart';
import 'package:flutter/material.dart';

class CompraPage extends StatefulWidget {
  final String compraId;
  const CompraPage({super.key, required this.compraId});

  @override
  State<CompraPage> createState() => _CompraPageState();
}

class _CompraPageState extends State<CompraPage> {
  final CompraStore store = CompraStore(
    repository: GetCompraReposiroty(
      request: GetCompraFirestore(),
    ),
  );

  @override
  void initState() {
    super.initState();

    store.getCompra(compraId: widget.compraId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF1F1F1F),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0XFF1F1F1F),
        centerTitle: true,
        title: const Text(
          'COMPRA',
          style: TextStyle(
              fontFamily: fontGlobal,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge([
          store.isLoading,
          store.error,
          store.success,
        ]),
        builder: (context, child) {
          if (store.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else if (store.error.value.isNotEmpty) {
            return Center(
              child: Text(
                store.error.value,
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else {
            final compra = store.success.value;
            final dataCompra = rewriteDateLancamento(data: compra.data);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'REALIZADA DIA $dataCompra',
                    style: const TextStyle(
                        color: Colors.white, fontFamily: fontGlobal),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 40, bottom: 20, left: 20),
                  child: Text(
                    'PRODUTOS: ',
                    style:
                        TextStyle(fontFamily: fontGlobal, color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: ListView.builder(
                        // padding: const EdgeInsets.only(bottom: 30),
                        itemCount: compra.produtos.length,
                        itemBuilder: (_, id) {
                          final produto = compra.produtos[id];
                          return ListTile(
                            leading: Text(produto.quantidade.toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: fontGlobal)),
                            title: Text(produto.nome,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: fontGlobal)),
                            trailing: Text(
                                'R\$ ${produto.valor.toStringAsFixed(2).replaceAll('.', ',')}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: fontGlobal)),
                          );
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TOTAL: R\$ ${compra.total.toStringAsFixed(2).replaceAll('.', ',')}',
                        style: const TextStyle(
                            color: Colors.white, fontFamily: fontGlobal),
                        // textAlign: TextAlign.end,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                            'QUANTIDADE DE PARCELAS: ${compra.quantidadeParcelas}',
                            style: const TextStyle(
                                color: Colors.white, fontFamily: fontGlobal)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: SizedBox(
                          height: 400,
                          child: Text(
                            'OBSERVAÇÃO: ${compra.observacao}',
                            style: const TextStyle(
                                color: Colors.white, fontFamily: fontGlobal),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
