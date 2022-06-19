import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EquipoScreen extends StatelessWidget {
  const EquipoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String nombreEquipo = '';

    final elementos = ModalRoute.of(context)!.settings.arguments;

    final equipoController = TextEditingController(text: "");

    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: equipoController,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Nombre del Equipo'),
                ),
                const SizedBox(
                  height: 20,
                ),
                OutlinedButton(
                    onPressed: () {
                      guardarPreferencias(context, equipoController.text);
                    },
                    child: const Text("Guardar Equipo")),
                GridView.count(
                  crossAxisCount: 2,
                  children: _builElements(),
                )
              ]),
        ),
      ),
    );
  }

  List<Widget> _builElements() {
    List<Widget> dev = [];
    for (var i = 1; i < 6; i++) {
      dev.add(
        Card(
          color: Colors.green,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
          child: SizedBox(
            height: 200,
            width: 200,
            child: FadeInImage(
              placeholder: const AssetImage('assets/jar-loading.gif'),
              image: NetworkImage(
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${i}.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      );
    }
    return dev;
  }

  Future<void> obtenerPreferencias() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    var nombreEquipo = preferences.getString("Nombreequipo")!;
    // ignore: avoid_print
    print(nombreEquipo);
  }

  Future<void> guardarPreferencias(context, nombreEquipo) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // ignore: avoid_print
    print(nombreEquipo);
    await preferences.setString("nombreEquipo", nombreEquipo);
    if (nombreEquipo != '') {
      Navigator.pushNamed(context, 'pokelista');
    }
  }
}
