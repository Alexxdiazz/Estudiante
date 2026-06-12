import 'package:crud/Cursando.dart';
import 'package:crud/Cursando_dao.dart';
import 'package:flutter/material.dart';

class Pag3 extends StatefulWidget {
  const Pag3({super.key});

  @override
  State<Pag3> createState() => _Pag3State();
}

class _Pag3State extends State<Pag3> {
  final _cursandoDAO = CursandoDao();

  Cursando? _cursandoAtual;

  final _controllerEstudiante = TextEditingController();
  final _controllerDisciplina = TextEditingController();

  List<Cursando> _listaCursando = [];

  @override
  void initState() {
    _loadCursando();
    super.initState();
  }

  _loadCursando() async {
    List<Cursando> temp =
        await _cursandoDAO.listarCursando();

    setState(() {
      _listaCursando = temp;
    });
  }

  _salvarOEditar() async {
    if (_cursandoAtual == null) {

      await _cursandoDAO.incluirCursando(
        Cursando(
          estudianteId:
              int.parse(_controllerEstudiante.text),
          disciplinaId:
              int.parse(_controllerDisciplina.text),
        ),
      );

    } else {

      _cursandoAtual!.estudianteId =
          int.parse(_controllerEstudiante.text);

      _cursandoAtual!.disciplinaId =
          int.parse(_controllerDisciplina.text);

      await _cursandoDAO.editarCursando(
        _cursandoAtual!,
      );
    }

    _controllerEstudiante.clear();
    _controllerDisciplina.clear();

    _cursandoAtual = null;

    _loadCursando();
  }

  _apagarCursando(int id) async {
    await _cursandoDAO.deleteCursando(id);
    _loadCursando();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CRUD Cursando"),
        backgroundColor: Colors.cyan,
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _controllerEstudiante,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "ID Estudiante",
                border: OutlineInputBorder(),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _controllerDisciplina,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "ID Disciplina",
                border: OutlineInputBorder(),
              ),
            ),
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: _salvarOEditar,
              child: Text(
                _cursandoAtual == null
                    ? "Salvar"
                    : "Atualizar",
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: _listaCursando.length,
              itemBuilder: (context, index) {

                final item =
                    _listaCursando[index];

                return ListTile(
                  title: Text(
                    "Estudiante ${item.estudianteId}",
                  ),
                  subtitle: Text(
                    "Disciplina ${item.disciplinaId}",
                  ),

                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _apagarCursando(item.id!);
                    },
                  ),

                  onTap: () {
                    setState(() {
                      _cursandoAtual = item;

                      _controllerEstudiante.text =
                          item.estudianteId.toString();

                      _controllerDisciplina.text =
                          item.disciplinaId.toString();
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}