//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//Module de gestion des communes
//SAS MANAGER v0.1.5

import 'package:flutter/material.dart';
import 'package:sasprojectv1/screen/commune/communesList.dart';
//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//SAS MANAGER v1.0.2

import 'package:sasprojectv1/models/commune.dart';
import 'package:sasprojectv1/models/secteur.dart';
import 'package:sasprojectv1/screen/tools/loading.dart';

class CommuneManager extends StatelessWidget {

  final List<Commune> communeList;
  final List<Secteur> secteurList;
  CommuneManager({this.communeList,this.secteurList});

  
  @override
  Widget build(BuildContext context) {

    if (secteurList.length==0){

      return Loading();

    }else{

      
      return Scaffold(
          appBar: AppBar(
            title: Text('Gestion des communes'),
            backgroundColor: Colors.orange[300],
            actions: [
              
            ],
          ),
          body: CommunesList(secteurs: secteurList,communeList: communeList,),
        );
  }
    }
    
}