import 'package:examen/model/pokelist_response.dart';
import 'package:examen/provider/pokemon_provider.dart';
import 'package:flutter/material.dart';
import 'package:selectable_container/selectable_container.dart';

class SelectPokemon extends StatefulWidget {
  const SelectPokemon({Key? key}) : super(key: key);

  @override
  State<SelectPokemon> createState() => _SelectPokemonState();
}

class _SelectPokemonState extends State<SelectPokemon> {
  final List<bool> _selectedItems = [];

  @override
  void dispose() {
    super.dispose();
  }

  Future<PokeList>? pokemon;

  @override
  void initState() {
    super.initState();
    pokemon = PokemonProvider().pokemonIndice();
    for (var i = 0; i < 149; i++) {
      _selectedItems.add(false);
    }
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
                child: Text('error'),
              );
            }
          }
        },
      ),
    );
  }

  Widget selectPokemon(BuildContext context, data) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeBottom: true,
      child: GridView.count(
        crossAxisCount: 2,
        children: _builElements(),
      ),
    );
  }

  List<Widget> _builElements() {
    List<Widget> dev = [];
    for (var i = 1; i < 149; i++) {
      dev.add(SelectableContainer(
        selected: _selectedItems[i],
        unselectedIcon: Icons.check_box_outline_blank,
        iconAlignment: Alignment.topRight,
        iconSize: 24,
        iconColor: Colors.deepOrange[400]!,
        onValueChanged: (_) {
          _valueSelected(i);
        },
        child: Card(
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
      ));
    }
    return dev;
  }

  void scheduleRebuild() => setState(() {});
  List equipo = [];

  void _valueSelected(int index) {
    setState(() {
      _selectedItems[index] = !_selectedItems[index];
      equipo.add(index);
      if (equipo.length == 6) {
        setState(() {
          Navigator.pushNamed(context, 'equipo', arguments: {'equipo': equipo});
        });
      }
    });
  }
}
