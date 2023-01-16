import 'package:boutique_zando/Pages/accueil.dart';
import 'package:boutique_zando/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/espace.dart';

class Authentification extends StatefulWidget {
  @override
  State<Authentification> createState() => _AuthentificationState();
}

class _AuthentificationState extends State<Authentification> {
  TextEditingController login = TextEditingController(text: "admin");

  TextEditingController pwd = TextEditingController(text: "admin");

  String errorMessage = "";
  String buttonConnexionText = "Connexion";

  @override
  // affichage
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Color.fromRGBO(203, 243, 240, 1),
        //backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Espace(hauteur: 50),
              enTete(),
              Espace(hauteur: 60),
              iconApplication(),
              Espace(hauteur: 30),
              titreZoneSasie("Login"),
              loginChampSaisie(),
              Espace(hauteur: 30),
              titreZoneSasie("Mot de passe"),
              motDePasseChampSaisie(),
              Text(
                errorMessage,
                style: TextStyle(color: Colors.red),
              ),
              Espace(hauteur: 70),
              buttonValider(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonValider(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          if (buttonConnexionText == "Traitement en cours...") {
            print('Ne plus appuyer....');
            return;
          }
          bool resultat = await context
              .read<UserController>()
              .authentifierParAPIVersPHP(login.text, pwd.text);

          buttonConnexionText = "Traitement en cours...";
          setState(() {});
          await Future.delayed(Duration(milliseconds: 200), () {});

          buttonConnexionText = "Connexion";
          setState(() {});

          if (resultat) {
            errorMessage = "";
            setState(() {});
            context.read<UserController>().changerStatusConnexion(true);

            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
              return Accueil();
            }));
          } else {
            errorMessage = "Login/mot de passe incorrect";
            setState(() {});
          }
        },
        style: ElevatedButton.styleFrom(
            primary: Colors.white, shadowColor: Colors.red),
        child: Text(
          buttonConnexionText,
          style: TextStyle(fontSize: 25, color: Colors.blue),
        ));
  }

  Widget tempButtonValider() {
    return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            primary: Colors.blueAccent,
            side: BorderSide(color: Colors.red),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
        child: Text(
          'Connexion',
          style: TextStyle(fontSize: 25),
        ));
  }

  Widget loginChampSaisie() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: login,
        decoration: InputDecoration(labelText: "Login", filled: false),
      ),
    );
  }

  Widget motDePasseChampSaisie() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: pwd,
        obscureText: true,
        decoration: InputDecoration(labelText: "Mot de passe", filled: false),
      ),
    );
  }

  Widget titreZoneSasie(String titre) {
    return Center(
      child: Text(titre, style: TextStyle(fontSize: 25)),
    );
  }

  Widget enTete() {
    return const Center(
      child: Text(
        'Bienvenu à Zando Online',
        style: TextStyle(fontSize: 30, color: Colors.blue),
      ),
    );
  }

  /* Widget espace(double hauteur) {
    return SizedBox(
      height: hauteur,
    );
  }*/
  Widget iconApplication() {
    return const Center(
      child: Icon(
        Icons.add_shopping_cart,
        color: Colors.black,
        size: 90,
      ),
    );
  }
}
