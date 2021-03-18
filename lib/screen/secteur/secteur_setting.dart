//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//SAS MANAGER v1.0.2

import 'package:flutter/material.dart';
import 'package:sasprojectv1/services/secteurDataBase.dart';
import 'package:sasprojectv1/models/secteur.dart';
import 'package:sasprojectv1/screen/tools/loading.dart';

class SecteurSetting extends StatefulWidget {
  
  final bool create;
  final String uid;
  SecteurSetting({this.create,this.uid});

  @override
  _SecteurSettingState createState() => _SecteurSettingState(create: create,uid: uid);
}

class _SecteurSettingState extends State<SecteurSetting> {

  final bool create;
  final String uid;
  _SecteurSettingState({this.create,this.uid});

  final _formKey = GlobalKey<FormState>();

  String _currentName;

  @override
  Widget build(BuildContext context) {

    if (create==true){
      return Form(
      key: _formKey,
      child: Column(
        children: [
          Text('Gestion, création du secteur',style: TextStyle(fontSize: 14.0),),
          SizedBox(height: 10.0,),
          TextFormField(
            decoration: InputDecoration(hintText: 'Nom du secteur...'),
            validator: (val) => val.isEmpty ? 'Information obligatoire': null,
            onChanged: (val) => setState(()=> _currentName = val),
          ),
          SizedBox(height:10.0),
          Text('Uuid en création',style: TextStyle(fontSize: 10,)),
          SizedBox(height:30.0),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()){
                await SecteurDataBaseService().updateSecteurData('', _currentName);
                Navigator.pop(context);
              }
            },
            child: Text('Valider'),
          ),
        ],
      ),
    );
    }else{
      return StreamBuilder<Secteur>(
        stream: SecteurDataBaseService(sectorId: uid).secteurData,
        builder: (context, snapshot) {
          if(snapshot.hasData){

            Secteur secteurData = snapshot.data;

            return Form(
            key: _formKey,
            child:Column(
              children: [
                Text('Gestion, création du secteur',style: TextStyle(fontSize: 14.0),),
                SizedBox(height: 10.0,),
                TextFormField(
                  initialValue: secteurData.nom,
                  decoration: InputDecoration(hintText: 'Nom du secteur...'),
                  validator: (val) => val.isEmpty ? 'Information obligatoire': null,
                  onChanged: (val) => setState(()=> _currentName = val),
                ),
                SizedBox(height:10.0),
                Text(secteurData.uuid,style: TextStyle(fontSize: 10,)),
                SizedBox(height:30.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()){
                      await SecteurDataBaseService().updateSecteurData(
                        secteurData.uuid, 
                        _currentName?? secteurData.nom
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Valider'),
                ),
              ],
            ),
          );
          }else{
            return Loading();
          }
        }
      );
    }
    
  }
}