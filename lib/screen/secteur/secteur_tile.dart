//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//SAS MANAGER v1.0.2

import 'package:flutter/material.dart';
import 'package:sasprojectv1/models/secteur.dart';
import 'package:sasprojectv1/screen/secteur/secteur_setting.dart';

class SecteurTile extends StatelessWidget {
  
  final Secteur secteur;
  SecteurTile({this.secteur});

  @override
  Widget build(BuildContext context) {

    void _showCreatingPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          color: Colors.blueGrey[100],
          padding: EdgeInsets.symmetric(vertical:20, horizontal:60.0),
          child : SecteurSetting(create: false,uid: secteur.uuid,),
        );
      });
    }

    return Padding(
      padding: EdgeInsets.only(top:8.0),
      child: Card(
        color: Colors.blueGrey[100],
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.orangeAccent[200],
                child: Text(secteur.nom.substring(0,2)),
              ),
              title: Text(secteur.nom),
              subtitle: Text(secteur.uuid),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 20.0,),
                TextButton(
                  onPressed: (){
                    _showCreatingPanel();
                  },
                  child: Text('MODIFIER'),
                ),
                SizedBox(width:20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}