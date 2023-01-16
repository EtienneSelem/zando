import 'package:flutter/material.dart';

import '../models/article_model.dart';

class ArticleController with ChangeNotifier {
  List<ArticleModel> listArticles = []; // liste initiale

  // focntion pour ajouter un article
  void ajouterArticle(ArticleModel data) {
    data.id = listArticles.length + 1;
    listArticles.add(data);
    notifyListeners();
  }
}

void main() {
  var controller = ArticleController();
  print("1: taille liste  ${controller.listArticles.length}");

  var data = ArticleModel(nom: "Lait", quantiteInitiale: 10, pu: 12.5);
  controller.ajouterArticle(data);

  print("2: taille liste  ${controller.listArticles.length}");
}
