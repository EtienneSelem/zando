import 'package:boutique_zando/controllers/activite_controller.dart';
import 'package:boutique_zando/controllers/user_controller.dart';
import 'package:boutique_zando/utils/espace.dart';
import 'package:boutique_zando/widgets/menu_lateral.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/utilitaires.dart';
import '../widgets/StatistiqueWidget.dart';

class Accueil extends StatefulWidget {
  Accueil({Key? key}) : super(key: key);

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  EdgeInsets paddingVal = EdgeInsets.symmetric(horizontal: 20, vertical: 5);
  List<String> listeTypesTransaction = [
    'Entrées/Sorties',
    "Entrées",
    "Sorties"
  ];
  String typeTransactionSelectionne = 'Entrées/Sorties';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // code executé une seule fois quand la page est lancée
      // ne fonctionne pas avec Ctrl+S quand vous voulez actualiser la pge
      // utilisé pour exploiter la variable context
      context.read<UserController>().recupererListeUserPHP();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Utilitaires.DEFAULT_COLOR,
        drawer: Drawer(
          child: MenuLateral(),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text('Zando Online'),
          actions: [
            IconButton(
              icon: Icon(Icons.sync),
              onPressed: () {
                context.read<UserController>().recupererListeUserPHP();
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.account_balance),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Espace(
              hauteur: 20,
            ),
            enteteRecherche(),
            Espace(
              hauteur: 10,
            ),
            statsCaisse(context),
            Espace(
              hauteur: 10,
            ),
            lignesStatistiques(context),
            enteteListeTransactions(context),
            Expanded(
                child: Container(
              color: Colors.white,
              child: listeTransactions(context),
            ))
          ],
        ),

        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  enteteRecherche() {
    return Container(
      padding: paddingVal,
      //color: Colors.grey.withOpacity(.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              textAlign: TextAlign.left,
              style: TextStyle(fontStyle: FontStyle.normal),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.white),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  iconColor: Colors.white,
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: "Effectuez une recherche...",
                  fillColor: Colors.white),
            ),
          ),
          Espace(
            largeur: 20,
          ),
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                // simuler l'achat
                context
                    .read<ActiviteController>()
                    .simulerActivite(operationAchat: true);
              },
              icon: Icon(
                Icons.remove_circle,
                size: 50,
                color: Colors.orange,
              )),
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                // simuler la vente
                context
                    .read<ActiviteController>()
                    .simulerActivite(operationAchat: false);
              },
              icon: Icon(
                Icons.add_circle,
                size: 50,
                color: Colors.green,
              ))
        ],
      ),
    );
  }

  lignesStatistiques(BuildContext context) {
    var achats = context.watch<ActiviteController>().sommeAchats;
    var progressionAchat = context.watch<ActiviteController>().progresionAchat;
    var ventes = context.watch<ActiviteController>().sommeVentes;
    var progressionVentes =
        context.watch<ActiviteController>().progresionVentes;
    var benef = context.watch<ActiviteController>().sommeBenefice;
    return Container(
      height: 80,
      //color: Colors.red,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Container(
            width: 250,
            //le Widget pour card
            child: StatistiqueWidget(
              titre: "Depenses",
              valeur: achats,
              progression: progressionAchat,
            ),
          ),
          Container(
            width: 250,
            //le Widget pour card
            child: StatistiqueWidget(
              titre: "Revenus",
              valeur: ventes,
              progression: progressionVentes,
            ),
          ),
          Container(
            width: 250,
            //le Widget pour card
            child: StatistiqueWidget(
              titre: "Benefice",
              valeur: benef,
              progression: 0,
              isBenefice: true,
            ),
          ),
        ],
      ),
    );
  }

  enteteListeTransactions(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: paddingVal.copyWith(left: 2, right: 2),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.sync),
          ),
          Text(
            "10 Dern. Trans.",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Spacer(),
          selectionTypeTransaction(context)
        ],
      ),
    );
  }

  statsCaisse(BuildContext context) {
    var sommeCaisse = context.watch<ActiviteController>().sommeCaisse;
    return Container(
      //color: Colors.transparent,
      padding: paddingVal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mon Portefeuille',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18),
              ),
              Text(
                'A date: 01/01/2020',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 12),
              )
            ],
          ),
          Text(
            'CDF ${Utilitaires.formatAmount(sommeCaisse)}',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24),
          )
        ],
      ),
    );
  }

  listeTransactions(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Icon(
            Icons.remove_circle,
            size: 35,
          ),
          title: Text(
            "Achat Lait",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "10/10/2020",
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
          trailing: Text(
            "CDF 100",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 17, color: Colors.green),
          ),
        );
      },
    );
  }

  selectionTypeTransaction(BuildContext context) {
    return DropdownButton(
      value: typeTransactionSelectionne,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: listeTypesTransaction.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          typeTransactionSelectionne = newValue!;
        });
      },
    );
  }
}
