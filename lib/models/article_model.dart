// To parse this JSON data, do
//
//     final articleModel = articleModelFromJson(jsonString);

import 'dart:convert';


class ArticleModel {
  ArticleModel({
    this.id,
    this.nom,
    this.quantiteInitiale,
    this.pu,
  });

  int? id;
  String? nom;
  int? quantiteInitiale;
  double? pu;

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
    id: json["id"] == null ? null : json["id"],
    nom: json["nom"] == null ? null : json["nom"],
    quantiteInitiale: json["quantite_initiale"] == null ? null : json["quantite_initiale"],
    pu: json["pu"] == null ? null : json["pu"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "nom": nom == null ? null : nom,
    "quantite_initiale": quantiteInitiale == null ? null : quantiteInitiale,
    "pu": pu == null ? null : pu,
  };
}
