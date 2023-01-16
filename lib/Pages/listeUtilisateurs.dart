import 'package:boutique_zando/Pages/FormulaireUser.dart';
import 'package:boutique_zando/controllers/user_controller.dart';
import 'package:boutique_zando/utils/utilitaires.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/espace.dart';

class ListeUtilisateurs extends StatelessWidget {
  const ListeUtilisateurs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listUsers = context.watch<UserController>().listUsers;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Utilitaires.DEFAULT_COLOR,
        title: Text("Utilisateurs (${listUsers.length})"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return FormulaireUsers();
                }));
              },
              iconSize: 40,
              icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Espace(hauteur: 30),
          Expanded(child: listeUsersView(context))
        ],
      ),
    );
  }

  listeUsersView(BuildContext context) {
    var listUsers = context.watch<UserController>().listUsers;
    return ListView.builder(
        shrinkWrap: true,
        itemCount: listUsers.length,
        itemBuilder: (context, index) {
          var couleur = index % 2 == 0
              ? Colors.transparent
              : Colors.grey.withOpacity(0.3);
          var user = listUsers[index];

          return Container(
            color: couleur,
            child: ListTile(
              leading: Icon(
                Icons.account_circle,
                size: 30,
              ),
              title: Text(
                '${user.name}',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              subtitle: Text(
                'Genre: ${user.genre}',
                style: TextStyle(fontSize: 15),
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit),
              ),
            ),
          );

          return Text(
            '${user.name}',
            style: TextStyle(fontSize: 30, color: couleur),
          );
        });
  }
}
