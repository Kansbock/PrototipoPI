import 'package:flutter/material.dart';
import 'package:projetoeureka3/appbar.dart';
import 'buscaAluno.dart'; 

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String metodo = '';
  TextEditingController textController = TextEditingController();

  Color alunoButtonColor = Colors.white;
  Color projetoButtonColor = Colors.white;

  TextStyle _buttonTextStyle(Color buttonColor) {
    return TextStyle(
      color: buttonColor == Colors.blue ? Colors.white : Colors.black,
    );
  }

  void _search() {
    if (metodo == "Aluno") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BuscaAluno()),
      );
    } else if (metodo == "Projeto") {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarM(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Text(
                "Buscar por $metodo:",
                style: const TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 40, 30, 30),
              child: TextField(
                controller: textController,
                onSubmitted: (value) {
                  _search(); // Chama a função de pesquisa quando pressionar Enter
                },
                decoration: const InputDecoration(
                  hintText: 'Digite aqui',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 150, 0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        metodo = "Aluno";
                        alunoButtonColor = Colors.blue; 
                        projetoButtonColor = Colors.white; 
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(alunoButtonColor),
                    ),
                    child: Text(
                      "Aluno",
                      style: _buttonTextStyle(alunoButtonColor), 
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      metodo = "Projeto";
                      projetoButtonColor = Colors.blue; 
                      alunoButtonColor = Colors.white; 
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(projetoButtonColor),
                  ),
                  child: Text(
                    "Projeto",
                    style: _buttonTextStyle(projetoButtonColor), // Aplicando o estilo
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
