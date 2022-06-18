import 'package:examen/model/pokelist_response.dart';
import 'package:examen/provider/pokemon_provider.dart';
import 'package:examen/widget/selectable_item.dart';
import 'package:flutter/material.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';

class SelectPokemon extends StatefulWidget {
  const SelectPokemon({Key? key}) : super(key: key);

  @override
  State<SelectPokemon> createState() => _SelectPokemonState();
}

class _SelectPokemonState extends State<SelectPokemon> {
  final controller = DragSelectGridViewController();

  @override
  void dispose() {
    controller.removeListener(scheduleRebuild);
    super.dispose();
  }

  Future<PokeList>? pokemon;

  @override
  void initState() {
    super.initState();
    pokemon = PokemonProvider().pokemonIndice();
    controller.addListener(scheduleRebuild);
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

              return selectPokemon(
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        child: const Icon(Icons.plus_one),
        onPressed: () {
          Navigator.pushNamed(context, 'detalles');
        },
      ),
    );
  }

  Widget selectPokemon(BuildContext context, data) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: DragSelectGridView(
          gridController: controller,
          padding: const EdgeInsets.all(8),
          itemCount: 150,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index, selected) {
            return SelectableItem(
              index: index,
              color: Colors.blue,
              selected: selected,
            );
          },
        ));
  }

  void scheduleRebuild() => setState(() {});
}
