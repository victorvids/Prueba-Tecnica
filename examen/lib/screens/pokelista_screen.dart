import 'package:examen/model/poke_response.dart';
import 'package:examen/model/pokelist_response.dart';
import 'package:examen/provider/pokemon_provider.dart';
import 'package:flutter/material.dart';

class PokemonList extends StatefulWidget {
  const PokemonList({Key? key}) : super(key: key);

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  Future<PokeList>? pokemon;

  @override
  void initState() {
    super.initState();
    pokemon = PokemonProvider().pokemonIndice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<PokeList>(
      future: pokemon,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (snapshot.hasData) {
            final data = snapshot.data!.pokemonSummary;

            return PokemonList(
              context,
              data,
            );
          } else {
            return const Center(
              child: Text('Tidak ada data'),
            );
          }
        }
      },
    ));
  }

  PokemonList(BuildContext context, data) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: 150,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, 'detalles', arguments: index),
              child: Card(
                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0)),
                child: FadeInImage(
                  placeholder: AssetImage('assets/jar-loading.gif'),
                  image: NetworkImage(
                      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png'),
                ),
              ),
            );
          },
        ));
  }
}
