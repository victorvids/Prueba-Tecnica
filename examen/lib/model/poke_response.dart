// To parse this JSON data, do
//
//     final listPokeResponse = listPokeResponseFromMap(jsonString);
import 'dart:convert';

class ListPokeResponse {
  ListPokeResponse(
      {this.name, this.height, this.weight, this.sprites, this.order});

  String? name;
  int? height;
  int? weight;
  int? order;
  Sprites? sprites;

  /*factory ListPokeResponse.fromJson(String str) =>
      ListPokeResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());*/

  factory ListPokeResponse.fromJson(Map<String, dynamic> json) =>
      ListPokeResponse(
        name: json["name"],
        height: json["height"],
        weight: json["weight"],
        order: json["order"],
        sprites: Sprites.fromJson(json["sprites"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "height": height,
        "weight": weight,
        "order": order,
        "sprites": sprites!.toJson(),
      };
}

class Sprites {
  Sprites({
    this.backDefault,
    this.frontDefault,
  });

  String? backDefault;
  String? frontDefault;

  factory Sprites.fromJson(Map<String, dynamic> json) => Sprites(
        backDefault: json["back_default"],
        frontDefault: json["front_default"],
      );

  Map<String, dynamic> toJson() => {
        "back_default": backDefault,
        "front_default": frontDefault,
      };
}
