import 'package:examen/provider/pokemon_provider.dart';
import 'package:flutter/material.dart';

import 'screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prueba Tecnica',
      //home: HomeScreen(),
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => const HomeScreen(),
        'pokelista': (BuildContext context) => const PokemonList(),
        'detalles': (BuildContext context) => const DetallesPokemon(
              url: '',
            ),
      },
    );
  }
}
