import 'package:crud/estudiante.dart';
import 'package:crud/estudiante_dao.dart';
import 'package:flutter/material.dart';

class pag1 extends StatefulWidget {
  const pag1({super.key});

  @override
  State<pag1> createState() => _pag1State();
}

class _pag1State extends State<pag1> {
  final _estudianteDAO = EstudianteDao();
  Estudiante? _estudianteAtual;

  final _controllerNombre = TextEditingController();
  final _controllerMatricula = TextEditingController();
  List<Estudiante> _listaEstudiantes = [
    Estudiante(nombre: "Fulano", matricula: "123456"),
    Estudiante(nombre: "Ciclano", matricula: "789123"),
    Estudiante(nombre: "Jorge", matricula: "7654321")
  ];

  @override
  void initState() {
    _loadEstudiantes();
    super.initState();
  }

  _loadEstudiantes() async {
    List<Estudiante> temp = await _estudianteDAO.listarEstudiantes();
    setState(() {
      _listaEstudiantes = temp;
    });
  }

  _salvarOEditar() async {
    if (_estudianteAtual == null) {
      await _estudianteDAO.incluirEstudiante(Estudiante(
          nombre: _controllerNombre.text, matricula: _controllerMatricula.text));
    } else {
      _estudianteAtual!.nombre = _controllerNombre.text;
      _estudianteAtual!.matricula = _controllerMatricula.text;
      await _estudianteDAO.editarEstudiante(_estudianteAtual!);
    }
    _controllerNombre.clear();
    _controllerMatricula.clear();
    setState(() {
      _loadEstudiantes();
      _estudianteAtual = null;
    });
  }

  _apagarEstudiante(int index) async {
    await _estudianteDAO.deleteEstudiante(index);
    _loadEstudiantes();
  }

  _editarEstudiante(Estudiante e) async {
    await _estudianteDAO.editarEstudiante(e);
    _loadEstudiantes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CRUD Estudiante"),
        backgroundColor: Colors.cyan,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controllerNombre,
              decoration: InputDecoration(
                labelText: "Nombre",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controllerMatricula,
              decoration: InputDecoration(
                labelText: "Matricula",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                _salvarOEditar();
              },
              child:
                  _estudianteAtual == null ? Text("Salvar") : Text("Atualizar"),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _listaEstudiantes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_listaEstudiantes[index].nombre),
                  subtitle: Text(_listaEstudiantes[index].matricula),
                  trailing: IconButton(
                    onPressed: () {
                      _apagarEstudiante(_listaEstudiantes[index].id!);
                    },
                    icon: Icon(Icons.delete),
                  ),
                  onTap: () {
                    setState(() {
                      _estudianteAtual = _listaEstudiantes[index];
                      _controllerNombre.text = _estudianteAtual!.nombre;
                      _controllerMatricula.text = _estudianteAtual!.matricula;
                      _editarEstudiante(_estudianteAtual!);
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