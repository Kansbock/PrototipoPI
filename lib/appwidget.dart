import 'package:flutter/material.dart';
import 'package:projetoeureka3/buscaAluno.dart';
import 'package:projetoeureka3/homepage.dart';

class AppMaterial extends StatelessWidget {
  const AppMaterial({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Eureka Protótipo",
      home: BuscaAluno(),
    );
  }
}