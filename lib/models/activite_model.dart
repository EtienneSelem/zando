import 'package:boutique_zando/models/article_model.dart';

class ActiviteModel {
  int? id;
  ArticleModel article;
  double prixUnitaire;
  int quantite;
  bool isAchat;

  ActiviteModel({
    this.id,
    required this.article,
    required this.prixUnitaire,
    required this.quantite,
    required this.isAchat
  });
}
