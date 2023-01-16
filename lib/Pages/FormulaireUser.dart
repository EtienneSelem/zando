import 'package:boutique_zando/Pages/accueil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/user_controller.dart';
import '../models/user_model.dart';
import '../utils/espace.dart';

class FormulaireUsers extends StatelessWidget {
  TextEditingController nom = TextEditingController();
  TextEditingController pwrd = TextEditingController();
  TextEditingController genre = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Espace(hauteur: 50),
            iconApplication(),
            Espace(hauteur: 20),
            enTete(),
            Espace(
              hauteur: 20,
            ),
            zoneSaisieName(),
            Espace(
              hauteur: 20,
            ),
            zoneSaisiePwrd(),
            Espace(
              hauteur: 20,
            ),
            zoneSaisieG(),
            Espace(
              hauteur: 50,
            ),
            buttonValider(context)
          ],
        ),
      ),
    ));
  }

  zoneSaisiePwrd() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: pwrd,
        obscureText: true,
        decoration: const InputDecoration(
            labelText: "Entrez votre mot de passe", filled: false),
      ),
    );
  }

  zoneSaisieG() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: genre,
        decoration: const InputDecoration(
            labelText: "Entrez votre genre", filled: false),
      ),
    );
  }

  zoneSaisieName() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: nom,
        decoration:
            InputDecoration(labelText: "Entrez votre nom", filled: false),
      ),
    );
  }

  Widget iconApplication() {
    return const Center(child: Icon(Icons.add_shopping_cart_rounded, size: 35));
  }

  Widget enTete() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        Text(
          "AJOUT UTILISATEUR",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        Icon(
          Icons.supervised_user_circle_sharp,
          size: 50,
          color: Colors.blueAccent,
        )
      ],
    );
  }

  Widget buttonValider(BuildContext context) {
    return TextButton(
        onPressed: () {
          String nomTxt = nom.text;
          String pwrdTxt = pwrd.text;
          String genreTxt = genre.text;

          var data = UserModel(password: pwrdTxt, genre: genreTxt, name: nomTxt);
          context.read<UserController>().ajouterUser(data);
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
            primary: Colors.blueAccent, shadowColor: Colors.black),
        child: const Text(
          'AJOUTER',
          style: TextStyle(fontSize: 15, color: Colors.white),
        ));
  }
}
