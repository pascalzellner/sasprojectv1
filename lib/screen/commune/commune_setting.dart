//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//SAS MANAGER v1.0.2

import 'package:flutter/material.dart';
import 'package:sasprojectv1/models/commune.dart';
import 'package:sasprojectv1/services/communeDataBase.dart';
import 'package:sasprojectv1/services/database.dart';
import 'package:sasprojectv1/screen/tools/loading.dart';
import 'package:sasprojectv1/models/secteur.dart';

class CommuneSetting extends StatefulWidget {
  
  final String comuid;
  final List<Secteur> secteurList;
  CommuneSetting({this.comuid,this.secteurList});

  @override
  _CommuneSettingState createState() => _CommuneSettingState(comuid: comuid,secteurList: secteurList);
}

class _CommuneSettingState extends State<CommuneSetting> {

  final String comuid;
  final List<Secteur> secteurList;
  _CommuneSettingState({this.comuid,this.secteurList});

  final _formKey = GlobalKey<FormState>();
  

  String _currentSecteur;
  String _error ='';


  @override
  Widget build(BuildContext context) {

    return StreamBuilder<Commune>(
      stream: CommuneDataBaseService(comuid: comuid).communeData,
      builder: (context, snapshot) {
        if (snapshot.hasData){

          Commune communeData = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: [
                Text(communeData.nom + ' mise à jour du secteur SAS',style: TextStyle(fontSize: 14.0),),
                SizedBox(height:10.0),
                DropdownButtonFormField(
                        value: _currentSecteur??communeData.sasSecteur,
                        validator: (val) => val.isEmpty ? 'Information obligatoire': null,
                        items: secteurList.map((secteur){
                          
                          return DropdownMenuItem(
                            value:secteur.nom.toString(),
                            child: Text(secteur.nom.toString()),
                          );
                        }).toList(),
                        onChanged: (val){
                          setState(() {
                            _currentSecteur = val;
                          });
                        },
                        decoration: InputDecoration(hintText: 'Choisir un secteur SAS'),
                ),
                SizedBox(height:30.0),
                ElevatedButton(
                  onPressed: () async {

                    if (_formKey.currentState.validate()){
                      setState(() {
                        _error='';
                      });
                      
                      await DataBaseService().updateCommuneData(
                        communeData.uid, 
                        communeData.nom, 
                        communeData.code, 
                        communeData.codeDepartement, 
                        communeData.codeRegion, 
                        communeData.codePostal, 
                        _currentSecteur ?? communeData.sasSecteur
                      );
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        _error='Saisie non valide';
                      });
                    }

                  }, 
                  child: Text('Enregistrer')
                ),
                SizedBox(height:20.0),
                Text(_error, style: TextStyle(color: Colors.pinkAccent),),
              ],
            ),
          );
        } else {
          return Loading();
        }
        
      }
    );
  }
}