//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//SAS MANAGER v1.0.2

import 'package:flutter/material.dart';
import 'package:sasprojectv1/screen/secteur/secteur_setting.dart';
import 'package:sasprojectv1/screen/secteur/secteursList.dart';
import 'package:sasprojectv1/models/secteur.dart';

class SecteurManager extends StatefulWidget {
  
  final List<Secteur> secteurList;
  SecteurManager({this.secteurList});
  

  @override
  _SecteurManagerState createState() => _SecteurManagerState(secteurList: secteurList);
}

class _SecteurManagerState extends State<SecteurManager> {

  final List<Secteur> secteurList;
  _SecteurManagerState({this.secteurList});

  void _showCreatingPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          color: Colors.blueGrey[100],
          padding: EdgeInsets.symmetric(vertical:20, horizontal:60.0),
          child : SecteurSetting(create: true,uid: '',),
        );
      });
    }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: Text('Gestion des secteurs SAS'),
          backgroundColor: Colors.orange[300],
          actions: [
            TextButton.icon(
              onPressed: (){
                _showCreatingPanel();
              }, 
              icon: Icon(Icons.plus_one), 
              label: Text('Nouveau'),
            ),
            SizedBox(width:10.0),
          ],
        ),
        body: SecteursList(secteurList:secteurList,),
      );
  }
}