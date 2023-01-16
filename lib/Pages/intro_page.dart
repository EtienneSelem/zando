import 'package:flutter/material.dart';

import 'authentification.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  bool afficher = false;

  @override
  void initState() {
    super.initState();
    print(afficher);
    animationRetarde();
    // appeler la recuperation http
  }

  animationRetarde() async {
    await Future.delayed(Duration(milliseconds: 500));
    print('Afficher a changé de valeur');
    afficher = true;
    setState(() {});

    await Future.delayed(Duration(milliseconds: 500));
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return Authentification();
    }));
    //afficher = false;
    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print('Actualisation....');
    return Scaffold(
        body: Center(
      child: AnimatedOpacity(
        opacity: afficher ? 1 : 0,
        duration: Duration(seconds: 2),
        child: Container(
          height: 200,
          width: 200,
          color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Zando Online",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 30,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
