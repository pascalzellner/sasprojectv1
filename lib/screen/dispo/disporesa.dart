//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//Module de réservation d'une disponibilité
//SAS MANAGER v0.1.5

import 'package:flutter/material.dart';
import 'package:sasprojectv1/models/sasdispo.dart';
import 'package:sasprojectv1/services/dispoDataBase.dart';

class ResaForm extends StatefulWidget {
  
  final Sasdispo dispo;
  ResaForm({this.dispo});

  @override
  _ResaFormState createState() => _ResaFormState(dispo: dispo);
}

class _ResaFormState extends State<ResaForm> {

  final _formKey = GlobalKey<FormState>();

  String _emailValue;
  String _obs;
  String _affaire;
  String _doc;

  final Sasdispo dispo;
  _ResaFormState({this.dispo});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
         TextFormField(
          decoration: InputDecoration(hintText: 'Référence régulation'),
          validator: (val)=> val.isEmpty? 'N° affaire ou dossier obligatoire' : null,
          onChanged: (val){
            setState(() {
              _affaire=val;
            });
          },
        ),
        SizedBox(height:10.0),
        TextFormField(
          decoration: InputDecoration(hintText: 'Médecin traitant'),
          validator: (val)=> val.isEmpty? 'Médecin traitant obligatoire' : null,
          onChanged: (val){
            setState(() {
              _doc=val;
            });
          },
        ),
        SizedBox(height:10.0),
        TextFormField(
          decoration: InputDecoration(hintText: 'Mail ou identité du  patient'),
          validator: (val)=> val.isEmpty? 'Entrer un Email ou une Identité' : null,
          onChanged: (val){
            setState(() {
              _emailValue=val;
            });
          },
        ),
        SizedBox(height:10.0),
        TextFormField(
          decoration: InputDecoration(hintText: 'Observation médicale'),
          validator: (val)=> val.isEmpty? 'Saisir observation' : null,
          onChanged: (val){
            setState(() {
              _obs=val + ' - merci de compléter...';
            });
          },
          maxLines: 4,
        ),
        SizedBox(height: 30.0,),
        ElevatedButton(
          onPressed: () async {
            if(_formKey.currentState.validate()){
              await DispoDatabaseService().updateDispoData(
                dispo.sasdispoId, 
                dispo.sasdispoSecteur, 
                dispo.sasdispoDeb, 
                dispo.sasdispoEnd, 
                dispo.sasdispoEffectorName, 
                dispo.sasdispoEffectorId, 
                dispo.sasdispoEffectorSpe, 
                dispo.sasdispoType, 
                _emailValue, 
                false, 
                _doc, 
                _obs, 
                _affaire
              );
              Navigator.pop(context);
            }
          }, 
          child: Text('Enregister'),
        ),
      ],),
    );
  }
}