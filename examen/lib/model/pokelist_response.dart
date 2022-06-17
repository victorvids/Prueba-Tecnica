class PokeList {
  List<PokemonSummary>? pokemonSummary;

  PokeList({this.pokemonSummary});

  PokeList.fromJson(Map<String, dynamic> json) {
    pokemonSummary = <PokemonSummary>[];
    json['results'].forEach((item) {
      pokemonSummary!.add(PokemonSummary.fromJson(item));
    });
  }
}

class PokemonSummary {
  String? name;
  String? url;

  PokemonSummary({this.name, this.url});

  PokemonSummary.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}
