//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//SAS MANAGER v1.0.2

import 'package:flutter/material.dart';
import 'package:sasprojectv1/models/secteur.dart';
import 'package:sasprojectv1/screen/secteur/secteur_tile.dart';

class SecteursList extends StatefulWidget {
  final List<Secteur> secteurList;
  SecteursList({this.secteurList});

  @override
  _SecteursListState createState() => _SecteursListState(secteurList: secteurList);
}

class _SecteursListState extends State<SecteursList> {

  final List<Secteur> secteurList;
  _SecteursListState({this.secteurList});

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: secteurList.length,
      itemBuilder: (context,index){
        return SecteurTile(secteur: secteurList[index],);
      }
    );
  }
}