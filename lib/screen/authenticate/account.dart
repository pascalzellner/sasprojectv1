import 'package:flutter/material.dart';
import 'package:sasprojectv1/models/commune.dart';
import 'package:sasprojectv1/models/effector.dart';
import 'package:sasprojectv1/services/database.dart';

class UserAccount extends StatefulWidget {

  final Effector actualUser;
  final List<Commune> commmunes;
  UserAccount({this.actualUser,this.commmunes});
  @override
  _UserAccountState createState() => _UserAccountState(actualUser: actualUser,commmunes: commmunes);
}

class _UserAccountState extends State<UserAccount> {

  final Effector actualUser;
  final List<Commune> commmunes;
  _UserAccountState({this.actualUser,this.commmunes});

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

    return Scaffold(
      appBar: AppBar(
        title : Text('Mes informations')
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              if(_formKey.currentState.validate()){

                    //si c'est un ADM qui modifie la fct ADM est validée sinon mise à NP
                    if(_currentEffectorFct=='ADM'){
                      if(actualUser.effectorRole=='ADM'){
                        _currentEffectorFct='ADM';
                      }else{
                        setState(() {
                        _currentEffectorFct="NP";
                      });
                      }
                    }
                    //on va rechercher la commune dans la liste des communes

                    for(var commune in commmunes){
                      int test = commune.nom.compareTo(_currentEffectorCommune??actualUser.effectorCommune);
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
                      await DataBaseService(uid: actualUser.effectorId).updateEffectorData(
                          _currentEffectorSASSector??actualUser.sasSectorName, 
                          'NP', 
                          _currentEffectorFct??actualUser.effectorRole, 
                          _currentEffectorName??actualUser.effectorName, 
                          _currentEffectorSpe??actualUser.effectorSpe, 
                          'NP', 
                          _currentEffectorCommune??actualUser.effectorCommune, 
                          _currentEffectorCP??actualUser.effectorCP, 
                          _currentEffectorAdress??actualUser.effectorAddress, 
                          _currentEffectorRPPS??actualUser.effectorRPPS, 
                          _currentEffectorSector??actualUser.effectorSector, 
                          actualUser.effectorAppNb??0,
                      );
                      Navigator.pop(context);
                  }
            },
            tooltip: 'Enregistrer',
            child:Icon(Icons.save),
          )
      ],),
      body:Container(
        padding: const EdgeInsets.symmetric(vertical:20,horizontal:50),
        child: Form(
          key:_formKey,
          child:Column(
            children: <Widget>[
              // Text('Mettre à jour / secteur SAS: '+actualEffector.sasSectorName,style: TextStyle(fontSize: 12.0),),
              // SizedBox(height:10.0),
              //Nom prénom du user, effecteur
              TextFormField(
                initialValue: _currentEffectorName??actualUser.effectorName,
                decoration: InputDecoration(hintText: 'Nom Prénom'),
                validator: (val) => val.isEmpty ? '': null,
                onChanged: (val) => setState(()=> _currentEffectorName = val),
              ),
              //dropdown fonction SAS
              DropdownButtonFormField(
                value:_currentEffectorFct??actualUser.effectorRole,
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
                initialValue: _currentEffectorAdress??actualUser.effectorAddress,
                decoration:InputDecoration(hintText: 'Votre adresse...'),
                validator: (val) => val.isEmpty ? "" : null,
                onChanged: (val) => setState(()=> _currentEffectorAdress = val),
              ),
              //Commune de l'adresse utilise la liste des communes de la base
              DropdownButtonFormField(
                value:_currentEffectorCommune??actualUser.effectorCommune,
                decoration: InputDecoration(hintText: 'Commune'),
                validator: (val) => val.isEmpty ? "" : null,
                items: commmunes.map((fct){
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
                value:_currentEffectorSpe??actualUser.effectorSpe,
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
                value:_currentEffectorSector??actualUser.effectorSector,
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
                initialValue: _currentEffectorRPPS??actualUser.effectorRPPS,
                decoration:InputDecoration(hintText: 'Votre numéro RPPS'),
                validator: (val) => val.isEmpty ? "" : null,
                onChanged: (val) => setState(()=> _currentEffectorRPPS = val),
              ),
            ],
          ),
        ),
      ),
    );
  }
}