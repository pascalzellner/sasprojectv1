//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//SAS MANAGER v1.0.2

import 'package:flutter/material.dart';
import 'package:sasprojectv1/models/effector.dart';
import 'package:sasprojectv1/screen/effector/settings_form.dart';

class EffectorTile extends StatelessWidget {

  final Effector effector;
  EffectorTile({this.effector});

  @override
  Widget build(BuildContext context) {

    void _showSettingPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          color: Colors.blueGrey[100],
          padding: EdgeInsets.symmetric(vertical:20, horizontal:60.0),
          child : SettingsForm(actualEffector: effector,),
        );
      });
    }

    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: Card(
        color: Colors.orange[100],
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: Text(''),
              ),
              title:Text(effector.effectorName + ' - ' + effector.effectorRole),
              subtitle: Text(effector.effectorSpe+ ' - secteur SAS : '+effector.sasSectorName),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 70.0,),
                Text(effector.effectorAddress +' - '+effector.effectorCP + ' - ' + effector.effectorCommune, style: TextStyle(fontSize: 10.0,),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width:70.0,),
                Text('RPPS: '+effector.effectorRPPS+ ' - ' + 'Secteur: ' + effector.effectorSector, style: TextStyle(fontSize: 10.0),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 20.0,),
                TextButton(
                  onPressed: (){
                    _showSettingPanel();
                  },
                  child: Text('MODIFIER'),
                ),
                SizedBox(width:20),
                // TextButton(
                //   onPressed: (){

                //   },
                //   child: Text('CONSULTATION'),
                // ),
                // SizedBox(width:20)
              ],
            ),
          ],
        )
      ),
      );
  }
}

