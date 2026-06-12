import 'package:crud/Disciplina.dart';
import 'package:crud/Disciplina_dao.dart';
import 'package:flutter/material.dart';

class Pag2 extends StatefulWidget {
  const Pag2({super.key});

  @override
  State<Pag2> createState() => _Pag2State();
}

class _Pag2State extends State<Pag2> {
  final _disciplinaDAO = DisciplinaDao();
  Disciplina? _disciplinaAtual;

  final _controllerNombre = TextEditingController();
  final _controllerProfessor = TextEditingController();

  List<Disciplina> _listaDisciplinas = [];

  @override
  void initState() {
    _loadDisciplinas();
    super.initState();
  }

  _loadDisciplinas() async {
    List<Disciplina> temp =
        await _disciplinaDAO.listarDisciplinas();

    setState(() {
      _listaDisciplinas = temp;
    });
  }

  _salvarOEditar() async {
    if (_disciplinaAtual == null) {

      await _disciplinaDAO.incluirDisciplina(
        Disciplina(
          nombre: _controllerNombre.text,
          profesor: _controllerProfessor.text,
        ),
      );

    } else {

      _disciplinaAtual!.nombre =
          _controllerNombre.text;

      _disciplinaAtual!.profesor =
          _controllerProfessor.text;

      await _disciplinaDAO.editarDisciplina(
        _disciplinaAtual!,
      );
    }

    _controllerNombre.clear();
    _controllerProfessor.clear();

    _disciplinaAtual = null;

    _loadDisciplinas();
  }

  _apagarDisciplina(int id) async {
    await _disciplinaDAO.deleteDisciplina(id);
    _loadDisciplinas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CRUD Disciplina"),
        backgroundColor: Colors.cyan,
      ),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _controllerNombre,
              decoration: const InputDecoration(
                labelText: "Nombre",
                border: OutlineInputBorder(),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _controllerProfessor,
              decoration: const InputDecoration(
                labelText: "Professor",
                border: OutlineInputBorder(),
              ),
            ),
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: _salvarOEditar,
              child: Text(
                _disciplinaAtual == null
                    ? "Salvar"
                    : "Atualizar",
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: _listaDisciplinas.length,
              itemBuilder: (context, index) {

                final disciplina =
                    _listaDisciplinas[index];

                return ListTile(
                  title: Text(disciplina.nombre),
                  subtitle:
                      Text(disciplina.profesor),

                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _apagarDisciplina(
                        disciplina.id!,
                      );
                    },
                  ),

                  onTap: () {
                    setState(() {
                      _disciplinaAtual =
                          disciplina;

                      _controllerNombre.text =
                          disciplina.nombre;

                      _controllerProfessor.text =
                          disciplina.profesor;
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