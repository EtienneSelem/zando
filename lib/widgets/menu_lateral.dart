import 'package:boutique_zando/Pages/authentification.dart';
import 'package:boutique_zando/Pages/listeUtilisateurs.dart';
import 'package:flutter/material.dart';

import '../utils/utilitaires.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
            decoration: BoxDecoration(color: Utilitaires.DEFAULT_COLOR),
            child: ListTile(
              leading: Icon(
                Icons.account_circle,
                size: 65,
                color: Colors.white,
              ),
              title: Text(
                "ODC",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              subtitle: Text(
                "Agent",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            )),
        ListTile(
          leading: Icon(
            Icons.people,
          ),
          title: const Text('Agents'),
          onTap: () {
            naviguerVersUtilisateurs(context);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.card_travel,
          ),
          title: const Text('Articles'),
          onTap: () {
            //Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.add_shopping_cart,
          ),
          title: const Text('Transactions'),
          onTap: () {
            //Navigator.pop(context);
          },
        ),
        Divider(
          thickness: 2,
        ),
        ListTile(
          leading: Icon(
            Icons.logout,
          ),
          title: const Text('Deconnexion'),
          onTap: () {
            naviguerVersAuthentification(context);
          },
        ),
      ],
    );
  }

  naviguerVersAuthentification(context) {
    // simuler la deconnexion
    Navigator.pop(context);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
      return Authentification();
    }));
  }

  naviguerVersUtilisateurs(context) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return ListeUtilisateurs();
    }));
  }
}
