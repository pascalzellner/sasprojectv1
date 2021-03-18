//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//SAS MANAGER v1.0.2


import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:sasprojectv1/models/sasuser.dart';

import 'package:sasprojectv1/screen/tools/loading.dart';
import 'package:sasprojectv1/screen/wrapper.dart';
import 'package:sasprojectv1/services/auth.dart';
import 'screen/tools/error.dart';

import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  //initialisation des connexion firebase
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context,snapshot){

        //on vérifie si il y a des erreurs
        if(snapshot.hasError){
          return MaterialApp(
            title: 'Erreur',
            home: Error(),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            theme: ThemeData(
              primaryColor: Colors.indigo[700],
              primaryColorLight: Colors.indigo[200],
              primaryColorDark: Colors.indigo[900],
              //primarySwatch: Colors.indigo[700],
              secondaryHeaderColor: Colors.orange[700],
              accentColor: Colors.orange[900],
            ),
            title:'SASManager',
            //on connecte l' APP au Stream d'authenfication
            home: StreamProvider<SasUser>.value(
              value: AuthService().user,
              child: Wrapper()
            ),
          );
       }

       // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
          title:'Chargement',
          home:Loading(),
        );
      }
    );
}
}