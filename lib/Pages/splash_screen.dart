import 'package:boutique_zando/Pages/accueil.dart';
import 'package:boutique_zando/Pages/authentification.dart';
import 'package:boutique_zando/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool is_visible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // code executé une seule fois quand la page est lancée
      // ne fonctionne pas avec Ctrl+S quand vous voulez actualiser la pge
      // utilisé pour exploiter la variable context

      bool connected = context.read<UserController>().checkStatusConnextion();
      if (connected) {
        naviguerVersAccueil();
      } else {
        ouvertureRetarde();
      }
    });


  }

  ouvertureRetarde() async {
    await Future.delayed(Duration(milliseconds: 1500));
    is_visible = true;
    setState(() {});
    await Future.delayed(Duration(milliseconds: 1500));
    naviguerSansRetourEnArriere();
  }

  naviguerSansRetourEnArriere() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
      return Authentification();
    }));
  }

  naviguerVersAccueil() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
      return Accueil();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          // If the widget is visible, animate to 0.0 (invisible).
          // If the widget is hidden, animate to 1.0 (fully visible).
          opacity: is_visible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 500),
          // The green box must be a child of the AnimatedOpacity widget.
          child: Container(
            alignment: Alignment.center,
            width: 200.0,
            height: 200.0,
            color: Colors.blue,
            child: Text(
              "Zando Online",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
        ),
      ),
    );
  }
}
