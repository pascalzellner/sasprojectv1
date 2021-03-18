//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//SAS MANAGER v1.0.2

import 'package:flutter/material.dart';
import 'package:sasprojectv1/models/commune.dart';
import 'package:sasprojectv1/screen/commune/commune_setting.dart';
import 'package:sasprojectv1/models/secteur.dart';

class CommuneTile extends StatelessWidget {
 
  final Commune commune;
  final List<Secteur> secteurs;
  CommuneTile({this.commune,this.secteurs});

  @override
  Widget build(BuildContext context) {

    

    void _showSettingPanel(String uid){

      showModalBottomSheet(context: context, builder: (context){
        return Container(
          color: Colors.blueGrey[100],
          padding: EdgeInsets.symmetric(vertical:20, horizontal:60.0),
          // secteurs donne accès à la liste statique des secteurs
          child : CommuneSetting(comuid: uid,secteurList: secteurs,),
        );
      });
    }

    Color _communeColor(){
      if (commune.sasSecteur == 'NP'){
        return Colors.blueGrey;
      } else {
        return Colors.green;
      }
    }

    return Padding(
      padding: EdgeInsets.only(top:8.0),
      child: Card(
        color: Colors.blueGrey[100],
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: _communeColor(),
                child:Text(commune.sasSecteur.substring(0,2)),
              ),
              title: Text(commune.nom),
              subtitle: Text('Secteur SAS: '+ commune.sasSecteur),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 20.0,),
                TextButton(
                  onPressed: (){
                    _showSettingPanel(commune.uid);
                  },
                  child: Text('MODIFIER'),
                ),
                SizedBox(width:20),
              ],
            ),
          ],)
      ),
    );
  }
}