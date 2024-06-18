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
          // textTheme: const TextTheme(
          //     // bodyText1: TextStyle(fontFamily: 'Poppins'),
          //     // bodyText2: TextStyle(fontFamily: 'Poppins'),
          //     ),
          useMaterial3: true,
        ),
        home: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: routes,
        ));
  }
}
