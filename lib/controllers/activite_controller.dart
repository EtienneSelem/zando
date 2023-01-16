import 'dart:math';

import 'package:boutique_zando/models/activite_model.dart';
import 'package:boutique_zando/models/article_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class ActiviteController with ChangeNotifier {
  double sommeInitialCaisse = 100000000;
  double sommeCaisse = 0;
  double sommeAchats = 0;
  double sommeVentes = 0;
  double sommeBenefice = 0;
  double progresionAchat = 0;
  double progresionVentes = 0;
  List<ActiviteModel> listActivites = [];

  ActiviteController() {
    // dans le constructeur, j'initialise la somme initiale
    sommeCaisse = sommeInitialCaisse;
    notifyListeners();
  }

  calculProgression(List<double> listTotaux, {bool calculAchat = true}) {
    // avant-dernière activité
    double prixTotal_n_1 = 0;
    if (listTotaux.length > 1) {
      prixTotal_n_1 = listTotaux[listTotaux.length - 2];
    }
    // dernière activité
    double prixTotal_n = listTotaux[listTotaux.length - 1];

    double progression = prixTotal_n_1 == 0
        ? 100.0
        : ((prixTotal_n - prixTotal_n_1) / prixTotal_n_1) * 100;

    if (calculAchat) {
      progresionAchat = progression;
    } else {
      progresionVentes = progression;
    }
    notifyListeners();
  }

  rapportCaisse({bool activiteAchat = true}) {
    // filtre par type d'activité et calcul des totaux de chaque activite
    List<double> listeTotauxActivite = listActivites
        .where((e) => e.isAchat == activiteAchat)
        .map((e) => e.prixUnitaire * e.quantite)
        .toList();
    // en important ce package, il facilite le calcul de la somme
    // import 'package:collection/collection.dart';
    double sommeTemp = listeTotauxActivite.sum;

    if (activiteAchat) {
      sommeCaisse = sommeInitialCaisse - sommeTemp;
      sommeAchats = sommeTemp;
      print("sommeAchats $sommeAchats");
    } else {
      sommeCaisse = sommeInitialCaisse + sommeTemp;
      sommeVentes = sommeTemp;
      print("sommeVentes $sommeVentes");
    }

    calculProgression(listeTotauxActivite, calculAchat: activiteAchat);
    sommeBenefice = sommeVentes - sommeAchats;

    notifyListeners();
  }

  simulerActivite({operationAchat = true}) {
    var articleTest =
        ArticleModel(id: 1, nom: "Lait", quantiteInitiale: 0, pu: 100);
    var prixAchat = (Random().nextInt(10000) + 5000) * 1.0;
    var quantite = (Random().nextInt(1) + 50);

    // premier achat
    var activite1 = ActiviteModel(
        article: articleTest,
        prixUnitaire: prixAchat,
        quantite: quantite,
        isAchat: operationAchat);

    // ajout de l'article simulé
    listActivites.add(activite1);

    // calcul des rapports
    rapportCaisse(activiteAchat: operationAchat);
    notifyListeners();
  }
}
