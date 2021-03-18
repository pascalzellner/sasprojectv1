//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//SAS MANAGER v1.0.2

import 'package:flutter/material.dart';
import 'package:sasprojectv1/models/effector.dart';
import 'package:sasprojectv1/services/database.dart';
import 'package:sasprojectv1/models/commune.dart';
import 'package:sasprojectv1/screen/tools/loading.dart';

class SettingsForm extends StatefulWidget {

  final Effector actualEffector;
  SettingsForm({this.actualEffector});

  @override
  _SettingsFormState createState() => _SettingsFormState(actualEffector: actualEffector);
}

class _SettingsFormState extends State<SettingsForm> {

  final Effector actualEffector;
  _SettingsFormState({this.actualEffector});

  final _formKey = GlobalKey<FormState>();

  final List<String> fcts = ["MRH","MSNP","ARM","OSNP","MEFFEC","MSNP-EFFEC","SEC","ADM","NP"];
  final List<String> sectorTypes = ["Médecin Hospitalier S1","Médecin Hospitalier S2","Médecin Libéral S1","Médecin Libéral S2","Médecin Libéral S3","NP"];
  final List<String> effectorSpes = ["Médecin Urgentiste","Médecin généraliste","Médecin pédiatre","Médecin Chirurgie Orale", "Médecin cardiologue","ARM/ONSP SAS","NP"];
  

  //form values
  String _currentEffectorName;
  String _currentEffectorSpe;
  String _currentEffectorAdress;
  String _currentEffectorCommune;
  String _currentEffectorSector;
  String _currentEffectorFct;
  String _currentEffectorRPPS;

  String _currentEffectorSASSector;
  String _currentEffectorCP;



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Commune>>(
      stream: DataBaseService().communes,
      builder: (context, snapshot) {

        if(snapshot.hasData){

          List<Commune> communes = snapshot.data;
          //on ajoute une commune NP

          return Form(
          key:_formKey,
          child:Column(
            children: <Widget>[
              // Text('Mettre à jour / secteur SAS: '+actualEffector.sasSectorName,style: TextStyle(fontSize: 12.0),),
              // SizedBox(height:10.0),
              //Nom prénom du user, effecteur
              TextFormField(
                initialValue: _currentEffectorName??actualEffector.effectorName,
                decoration: InputDecoration(hintText: 'Nom Prénom'),
                validator: (val) => val.isEmpty ? '': null,
                onChanged: (val) => setState(()=> _currentEffectorName = val),
              ),
              //dropdown fonction SAS
              DropdownButtonFormField(
                value:_currentEffectorFct??actualEffector.effectorRole,
                decoration: InputDecoration(hintText: 'Fonction SAS'),
                items: fcts.map((fct){
                  return DropdownMenuItem(
                    value:fct,
                    child: Text(fct), 
                  );
                }).toList(),
                onChanged:(val){
                  _currentEffectorFct=val;
                },
              ),
              //Adresse du praticien
              TextFormField(
                initialValue: _currentEffectorAdress??actualEffector.effectorAddress,
                decoration:InputDecoration(hintText: 'Votre adresse...'),
                validator: (val) => val.isEmpty ? "" : null,
                onChanged: (val) => setState(()=> _currentEffectorAdress = val),
              ),
              //Commune de l'adresse utilise la liste des communes de la base
              DropdownButtonFormField(
                value:_currentEffectorCommune??actualEffector.effectorCommune,
                decoration: InputDecoration(hintText: 'Commune'),
                validator: (val) => val.isEmpty ? "" : null,
                items: communes.map((fct){
                  return DropdownMenuItem(
                    value:fct.nom,
                    child: Text(fct.nom), 
                  );
                }).toList(),
                onChanged:(val){setState(() {
                  _currentEffectorCommune = val;
                });},
              ),
              //spécialité médicale du user
              DropdownButtonFormField(
                value:_currentEffectorSpe??actualEffector.effectorSpe,
                decoration: InputDecoration(hintText: 'Spécialité médicale'),
                validator: (val) => val.isEmpty ? "" : null,
                items: effectorSpes.map((fct){
                  return DropdownMenuItem(
                    value:fct,
                    child: Text(fct), 
                  );
                }).toList(),
                onChanged:(val){setState(() {
                  _currentEffectorSpe = val;
                });},
              ),
              //secteur d'installation CPAM
              DropdownButtonFormField(
                value:_currentEffectorSector??actualEffector.effectorSector,
                decoration: InputDecoration(hintText: 'Secteur CPAM'),
                validator: (val) => val.isEmpty ? "" : null,
                items: sectorTypes.map((fct){
                  return DropdownMenuItem(
                    value:fct,
                    child: Text(fct), 
                  );
                }).toList(),
                onChanged:(val){setState(() {
                  _currentEffectorSector = val;
                });},
              ),
              //RPPS du praticien
              TextFormField(
                initialValue: _currentEffectorRPPS??actualEffector.effectorRPPS,
                decoration:InputDecoration(hintText: 'Votre numéro RPPS'),
                validator: (val) => val.isEmpty ? "" : null,
                onChanged: (val) => setState(()=> _currentEffectorRPPS = val),
              ),
              SizedBox(height:10.0),
              ElevatedButton(
                onPressed: () async {
                  if(_formKey.currentState.validate()){

                    //si c'est un ADM qui modifie la fct ADM est validée sinon mise à NP
                    if(_currentEffectorFct=='ADM'){
                      if(actualEffector.effectorRole=='ADM'){
                        _currentEffectorFct='ADM';
                      }else{
                        setState(() {
                        _currentEffectorFct="NP";
                      });
                      }
                    }
                    //on va rechercher la commune dans la liste des communes

                    for(var commune in communes){
                      int test = commune.nom.compareTo(_currentEffectorCommune??actualEffector.effectorCommune);
                      if(test == 0){
                        setState(() {
                          _currentEffectorCP=commune.codePostal;
                        });
                        setState(() {
                          _currentEffectorSASSector=commune.sasSecteur;
                        });
                      }
                    }

                    //on mat à jour la base de donnée
                      await DataBaseService(uid: actualEffector.effectorId).updateEffectorData(
                          _currentEffectorSASSector??actualEffector.sasSectorName, 
                          'NP', 
                          _currentEffectorFct??actualEffector.effectorRole, 
                          _currentEffectorName??actualEffector.effectorName, 
                          _currentEffectorSpe??actualEffector.effectorSpe, 
                          'NP', 
                          _currentEffectorCommune??actualEffector.effectorCommune, 
                          _currentEffectorCP??actualEffector.effectorCP, 
                          _currentEffectorAdress??actualEffector.effectorAddress, 
                          _currentEffectorRPPS??actualEffector.effectorRPPS, 
                          _currentEffectorSector??actualEffector.effectorSector, 
                          actualEffector.effectorAppNb??0,
                      );
                      Navigator.pop(context);
                  }
                },
                child: Text('Enregistrer'),
              ),
            ],
          ),
        );

        } else{
          return Loading();
        }

        
      }
    );
  }
}