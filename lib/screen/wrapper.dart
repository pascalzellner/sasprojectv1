//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//SAS MANAGER v1.0.2

import 'package:flutter/material.dart';
import 'package:sasprojectv1/models/sasuser.dart';
import 'package:provider/provider.dart';
import 'package:sasprojectv1/screen/authenticate/authenticate.dart';
import 'package:sasprojectv1/screen/home.dart';
import 'package:sasprojectv1/models/effector.dart';
import 'package:sasprojectv1/models/commune.dart';
import 'package:sasprojectv1/models/secteur.dart';
import 'package:sasprojectv1/services/database.dart';
import 'package:sasprojectv1/services/secteurDataBase.dart';

class Wrapper extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {

    //on écoute la stream d'authentification
    final SasUser user = Provider.of<SasUser>(context);

    //si il n'y a pas de user identifié
    if(user==null){
      //on retourne le composant d'authentification
      return Authenticate();
    }else{
      //le user est identifié on retourne le composant principal que l'on encapsule dans un multiprovider
      return MultiProvider(
        providers: [
          StreamProvider<Effector>.value(value: DataBaseService(uid: user.uid).effectorData),
          StreamProvider<List<Commune>>.value(value: DataBaseService().communes),
          StreamProvider<List<Secteur>>.value(value: SecteurDataBaseService().secteurs),
        ],
        child: Home()
      );
    }
  }
}