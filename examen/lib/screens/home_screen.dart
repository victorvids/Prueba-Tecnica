import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final nombreController = TextEditingController(text: "");
  String nombre = '';

  String nom = '';

  @override
  void initState() {
    super.initState();
    //obtenerPreferencias();
    borrarPreferencias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 121, 133, 117),
      appBar: AppBar(
        title: const Text("Examen Técnico"),
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                borrarPreferencias();
              },
              icon: const Icon(Icons.delete_outline_outlined))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(30)),
              margin: const EdgeInsets.all(25),
              elevation: 10,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                width: double.infinity,
                height: 300,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: nombreController,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Aqui va tu nombre'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          guardarPreferencias(nombreController.text);
                        },
                        child: const Text("Guardar usuario"))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> obtenerPreferencias() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    nombre = preferences.getString("nombre")!;
    // ignore: avoid_print
    print(nombre);
    if (nombre != '') {
      setState(() {
        Navigator.pushNamed(context, 'pokelista');
      });
    }
  }

  Future<void> guardarPreferencias(nombre) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // ignore: avoid_print
    print(nombre);
    await preferences.setString("nombre", nombre);
    if (nombre != '') {
      setState(() {
        Navigator.pushNamed(context, 'pokelista');
      });
    }
  }

  Future<void> borrarPreferencias() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // ignore: avoid_print
    print('Borrar ');
    await preferences.clear();
  }
}
