import 'dart:convert';
import 'package:examen/model/poke_response.dart';
import 'package:examen/model/pokelist_response.dart';
import 'package:http/http.dart' as http;

class PokemonProvider {
  Future<PokeList> pokemonIndice() async {
    final Uri url = Uri.parse('https://pokeapi.co/api/v2/pokemon/');
    final response = await http.get(url);
    final data = PokeList.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception('Terjadi kesalahan');
    }
  }

  Future<ListPokeResponse> pokemonDetalles(url) async {
    //final Uri urii = Uri.parse(url);
    final response = await http.get(url);

    final data = ListPokeResponse.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception('Terjadi kesalahan');
    }
  }
}
