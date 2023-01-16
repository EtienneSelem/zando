import 'dart:convert';

import 'package:boutique_zando/utils/utilitaires.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class UserController with ChangeNotifier {
  GetStorage stockage = GetStorage();

  List<UserModel> listUsers = [
    UserModel(id: 1, name: "admin", password: "admin", genre: "", isAdmin: true)
  ];

  UserController() {
    recupererDansStockageLocale();
  }

  recupererDansStockageLocale() {
    //lecture base de données
    var tempList = stockage.read("LISTE_USERS") as List<dynamic>?;

    if (tempList != null) {
      listUsers = tempList.map((e) => UserModel.fromJson(e)).toList();
    }
    notifyListeners();
  }

  recupererListeUserPHP() async {
    print("Recuperation users");
    var url = Uri(
        scheme: "http",
        host: Utilitaires.HOST_URL,
        path: "api_flutter/liste_users.php");
    // http://localhost/api_flutter/liste_users.php
    var responses = await http.get(url);
    if (responses.statusCode == 200) {
      String donneesBrutes = responses.body;
      print(donneesBrutes);

      var tempList = json.decode(donneesBrutes) as List<dynamic>;
      List<UserModel> tempList2 =
          tempList.map((e) => UserModel.fromJson(e)).toList();
      listUsers.addAll(tempList2);
      //listUsers=[...tempList2,...listUsers, ];
      notifyListeners();
      print(tempList);
    }
  }

  void ajouterUser(UserModel data) {
    data.id = listUsers.length + 1;
    listUsers.add(data);
    // stockage en locale
    List<Map<String, dynamic>> tempListUser =
        listUsers.map((e) => e.toJson()).toList();
    stockage.write("LISTE_USERS", tempListUser);
    notifyListeners();
  }

  Future<bool> authentifier(String name, String motDePasse) async {
    var resultat = listUsers
        .where((e) => e.name == name && e.password == motDePasse)
        .toList();
    await Future.delayed(Duration(milliseconds: 300));
    return resultat.length == 0 ? false : true;
  }

  Future<bool> authentifierParAPIVersPHP(String name, String motDePasse) async {
    var url = Uri(
        scheme: "http",
        host: Utilitaires.HOST_URL,
        path: "/api_flutter/authentification.php");
    Map data = {"username": name, "password": motDePasse};

    var reponse = await http.post(url, body: json.encode(data));
    // consulter la reponse du serveur
    print(reponse.body);
    if (reponse.statusCode == 200) {
      var mapResponse = json.decode(reponse.body);
      return mapResponse['Status'];
    }
    return false;
  }

  bool checkStatusConnextion() {
    bool? status = stockage.read<bool>('is_connected');
    return status ?? false;
  }

  changerStatusConnexion(bool status) {
    stockage.write("is_connected", status);
    notifyListeners();
  }
}

void main() {
  var controller = UserController();
  print(controller.listUsers.length);

  // ajouter un userg
  var data = UserModel(name: "ODC", password: "odc", genre: "HF");
  controller.ajouterUser(data);

  print(controller.listUsers.length);
  var resultat = controller.authentifier("ODC", "odc");
  print(resultat);
}
