import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mysql1/mysql1.dart';

class BuscaAluno extends StatefulWidget {
  const BuscaAluno({Key? key}) : super(key: key);

  @override
  State<BuscaAluno> createState() => _BuscaAlunoState();
}

class _BuscaAlunoState extends State<BuscaAluno> {
  String? nomeAluno;
  String? nomeTrabalho;
  int? numeroEstande;
  String? descricaoTrabalho;
  bool isLoading = true; 

  Future<void> _fetchDataFromMySQL() async {
    try {
      final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'localhost',
        port: 3306, 
        user: 'root',
        password: '23.01182-3',
        db: 'Eureka_2023',
      ));

      Results result = await conn.query('''
        SELECT
        Eureka_2023.trabalhos.idTrabalho AS idTrabalho,
        Eureka_2023.trabalhos.numeroEstande AS numeroEstande,
        CONCAT(
            b.codigoHabilitacao,
            Eureka_2023.trabalhos.periodo,
            CONVERT(
                IF(
                    (Eureka_2023.trabalhos.numeroTG < 10),
                    CONCAT('0', Eureka_2023.trabalhos.numeroTG),
                    Eureka_2023.trabalhos.numeroTG
                )
                USING latin1
            )
        ) AS grupoTrabalho,
        b.codigoHabilitacao AS curTrabalho,
        Eureka_2023.usuarios.idUsuario AS idAluno,
        Eureka_2023.usuarios.nome AS nomeAluno,
        Eureka_2023.usuarios.registro AS raAluno,
        hab_alu.codigoHabilitacao AS curAluno,
        orientadores.idUsuario AS idOrientador,
        orientadores.nome AS nomeOrientador,
        orientadores.registro AS rfOrientador,
        Eureka_2023.trabalhos.titulo AS tituloTrabalho,
        Eureka_2023.trabalhos.Descricao AS descricaoTrabalho,
        CAST(
            RIGHT(
                DATABASE(),
                4
            ) AS UNSIGNED
        ) AS anoLetivo
    FROM
        Eureka_2023.usuarios
    JOIN
        Eureka_2023.trabalhos_usuarios
    ON
        Eureka_2023.usuarios.idUsuario = Eureka_2023.trabalhos_usuarios.idUsuario
    JOIN
        Eureka_2023.trabalhos
    ON
        Eureka_2023.trabalhos.idTrabalho = Eureka_2023.trabalhos_usuarios.idTrabalho
    JOIN
        Eureka_2023.usuarios orientadores
    ON
        orientadores.idUsuario = Eureka_2023.trabalhos.orientador
    JOIN
        Eureka_2023.habilitacoes b
    ON
        Eureka_2023.trabalhos.idHabilitacao = b.idHabilitacao
    JOIN
        Eureka_2023.habilitacoes hab_alu
    ON
        Eureka_2023.usuarios.idHabilitacao = hab_alu.idHabilitacao
    WHERE
        Eureka_2023.trabalhos.ativo = 1
        AND b.codigoHabilitacao NOT IN ('IMT', 'IE')
        AND `Eureka_2023`.`usuarios`.`nome` = 'ANA LUISA ALVES DA CUNHA';
      ''');

      for (var row in result) {
        setState(() {
          nomeAluno = row['nomeAluno'];
          nomeTrabalho = row['tituloTrabalho'];
          numeroEstande = row['numeroEstande'];
          descricaoTrabalho = row['descricaoTrabalho'];
          isLoading = false; 
        });
      }

      await conn.close();
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchDataFromMySQL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Aluno: ${nomeAluno ?? 'N/A'}"),
                  Text("Trabalho: ${nomeTrabalho ?? 'N/A'}"),
                  Text("Estande: ${numeroEstande ?? 'N/A'}"),
                  Text("Descrição: ${descricaoTrabalho ?? 'N/A'}"),
                ],
              ),
      ),
    );
  }
}
