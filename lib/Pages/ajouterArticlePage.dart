import 'package:boutique_zando/controllers/article_controller.dart';
import 'package:boutique_zando/utils/espace.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/article_model.dart';
import 'accueil.dart';

class AjouterArticlePage extends StatelessWidget {
  TextEditingController nom = TextEditingController();
  TextEditingController pu = TextEditingController();
  TextEditingController qty = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Espace(
                  hauteur: 50,
                ),
                entete(),
                //titreZoneSasie("Nom"),
                Espace(
                  hauteur: 30,
                ),
                nomArticleChampSaisie(),
                Espace(
                  hauteur: 10,
                ),
                //titreZoneSasie("Prix unitaire"),
                Espace(
                  hauteur: 10,
                ),
                prixUChampSaisie(),
                Espace(
                  hauteur: 10,
                ),
                //titreZoneSasie("Quantité"),
                Espace(
                  hauteur: 10,
                ),
                quantiteChampSaisie(),
                Espace(
                  hauteur: 230,
                ),
                //Spacer(),
                listeButtonsNavivations(context),
              ],
            ),
          ),
        ));
  }

  listeButtonsNavivations(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              // recuperer les valeurs du formulaire et convertir (avec risque de valeur vide)
              String nomText = nom.text;
              double puText = double.parse(pu.text);
              int qtyText = int.parse(qty.text);

              print(nomText);
              print(puText);
              print(qtyText);
              // creation de l'article avec le model
              var data = ArticleModel(
                  nom: nomText, quantiteInitiale: qtyText, pu: puText);

              // appel de la fonction definie dans le controlleur
              context.read<ArticleController>().ajouterArticle(data);

              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return Accueil();
              }));
            },
            child: Text('Ajouter'),
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50))),
      ],
    );
  }

  Widget entete() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "Ajouter un article",
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
        Icon(
          Icons.add_shopping_cart,
          size: 50,
        )
      ],
    );
  }

  Widget nomArticleChampSaisie() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        controller: nom,
        decoration:
        InputDecoration(labelText: "nom de l'article", filled: false),
      ),
    );
  }

  Widget prixUChampSaisie() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        controller: pu,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            labelText: "prix unitaire de l'article", filled: false),
      ),
    );
  }

  Widget quantiteChampSaisie() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        controller: qty,
        keyboardType: TextInputType.number,
        decoration:
        InputDecoration(labelText: "quantité de l'article", filled: false),
      ),
    );
  }

  Widget titreZoneSasie(String titre) {
    return Center(
      child: Text(titre, style: TextStyle(fontSize: 25)),
    );
  }
}
