import 'package:cartao_acessorios/routes.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // color: Color(0XFF1F1F1F),
        debugShowCheckedModeBanner: false,
        title: 'Cartão Acessorios',
        theme: ThemeData(
          // primaryColor: Color(0XFF1F1F1F),
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellowAccent),
          useMaterial3: true,
        ),
        home: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: routes,
        ));
  }
}
