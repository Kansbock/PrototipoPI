import 'package:flutter/material.dart';
import 'package:projetoeureka3/appbar.dart';
import 'package:projetoeureka3/mysql.dart';

class BuscaAluno extends StatefulWidget {
  const BuscaAluno({super.key});

  @override
  State<BuscaAluno> createState() => _BuscaAlunoState();
}

class _BuscaAlunoState extends State<BuscaAluno> {
  var db = new Mysql();
  var nome = '';
  var projeto = '';
  var estande = '';
  var desc = '';
  

  void _getAluno() {
    db.getConnection().then((conn) {
      String sql = """ SELECT
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
        AND `Eureka_2023`.`usuarios`.`nome` = 'ANA LUISA ALVES DA CUNHA';""";
      conn.query(sql).then((results) {
        for(var row in results){
          setState(() {
            nome = row['nomeAluno'];
            projeto = row['tituloTrabalho'];
            estande = row['numeroEstande'];
            desc = row['descricaoTrabalho'];
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBarM(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Aluno: $nome"),
            Text("Trabalho: $projeto"),
            Text("Estande: $estande"),
            Text("Descrição: $desc"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: _getAluno,
      tooltip: 'Increment',
      child: Icon(Icons.add),),
    );
  }
}
