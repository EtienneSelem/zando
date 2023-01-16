import 'package:flutter/material.dart';

import '../utils/utilitaires.dart';

class StatistiqueWidget extends StatelessWidget {
  String titre;
  double valeur;
  double progression;
  bool isBenefice;

  StatistiqueWidget(
      {required this.titre,
      required this.valeur,
      required this.progression,
      this.isBenefice = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(contentPadding: EdgeInsets.zero,
            leading: Container(
                //margin: EdgeInsets.only(top: 9),
                child: Icon(
              isBenefice
                  ? Icons.star
                  : (progression > 0
                      ? Icons.arrow_drop_up_outlined
                      : Icons.arrow_drop_down_outlined),
              size: 50,
              color: isBenefice
                  ? (valeur >= 0 ? Colors.orange : Colors.grey)
                  : (progression > 0 ? Colors.green : Colors.red),
            )),
            title: Text(
              "$titre",
              style: const TextStyle(fontSize: 15),
            ),
            subtitle: Text(
              "CDF ${Utilitaires.formatAmount(valeur)}",
              style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
