import 'package:examen/model/poke_response.dart';
import 'package:examen/provider/pokemon_provider.dart';
import 'package:flutter/material.dart';

class DetallesPokemon extends StatefulWidget {
  final String url;
  const DetallesPokemon({Key? key, required this.url}) : super(key: key);

  @override
  State<DetallesPokemon> createState() => _DetallesPokemonState();
}

class _DetallesPokemonState extends State<DetallesPokemon> {
  Future<ListPokeResponse>? pokemon;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final indice = ModalRoute.of(context)?.settings.arguments ?? 0;
    final int index = int.parse(indice.toString()) + 1;
    final Uri uri = Uri.parse('https://pokeapi.co/api/v2/pokemon/$index');
    pokemon = PokemonProvider().pokemonDetalles(uri);

    return FutureBuilder<ListPokeResponse>(
      future: pokemon,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasData) {
            // data
            final name = snapshot.data!.name;
            final height = snapshot.data!.height;
            final weight = snapshot.data!.weight;
            final order = snapshot.data!.order;
            final gambar1 = snapshot.data!.sprites!.frontDefault;
            return Scaffold(
              appBar: AppBar(
                title: Text('Pokemon $name'),
              ),
              body: Center(
                child: Card(
                  color: const Color.fromARGB(255, 122, 192, 124),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 40),
                    width: 300,
                    height: 450,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Image.network(
                          '$gambar1',
                          width: 300,
                          height: 150,
                        ),
                        Text(
                          'Nombre : $name',
                          style:
                              const TextStyle(fontSize: 18, color: Colors.blue),
                        ),
                        Text(
                          'Estatura : $height',
                          style:
                              const TextStyle(fontSize: 18, color: Colors.blue),
                        ),
                        Text(
                          'Peso : $weight',
                          style:
                              const TextStyle(fontSize: 18, color: Colors.blue),
                        ),
                        Text(
                          'Numero : $order',
                          style:
                              const TextStyle(fontSize: 18, color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            // eror
            return const Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
          }
        }
      },
    );
  }
}
