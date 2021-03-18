//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//Module d'affichage de la liste des communes
//SAS MANAGER v0.1.5

//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//SAS MANAGER v1.0.2

import 'package:flutter/material.dart';
import 'package:sasprojectv1/models/commune.dart';
import 'package:sasprojectv1/screen/commune/commune_tile.dart';
import 'package:sasprojectv1/models/secteur.dart';

class CommunesList extends StatefulWidget {

  final List<Secteur> secteurs;
  final List<Commune> communeList;
  CommunesList({this.secteurs,this.communeList});

  @override
  _CommunesListState createState() => _CommunesListState(secteurs: secteurs,communeList: communeList);
}

class _CommunesListState extends State<CommunesList> {
  
  final List<Secteur> secteurs;
  final List<Commune> communeList;
  _CommunesListState({this.secteurs,this.communeList});

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        itemCount: communeList.length,
        itemBuilder: (context,index){
          return CommuneTile(commune : communeList[index],secteurs: secteurs,);
        }
    );
  }
}
