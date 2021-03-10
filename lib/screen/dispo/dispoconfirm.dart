//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//Module de confirmation de mise à disposition
//SAS MANAGER v0.1.5

import 'package:flutter/material.dart';
import 'package:sasprojectv1/models/sasdispo.dart';
import 'package:sasprojectv1/services/dispoDataBase.dart';

class DispoConsultation extends StatefulWidget {

  final Sasdispo dispo;
  DispoConsultation({this.dispo});
  @override
  _DispoConsultationState createState() => _DispoConsultationState(dispo: dispo);
}

class _DispoConsultationState extends State<DispoConsultation> {

  final Sasdispo dispo;
  _DispoConsultationState({this.dispo});

   final _formKey = GlobalKey<FormState>();

  String _emailValue;
  String _obs;
  bool _flag;
  String _doc;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        Text('Référence SAS: '+dispo.sasdispoAffaire),
        SizedBox(height:10.0),
        TextFormField(
          initialValue: _doc??dispo.sasdispoPatientMt,
          decoration: InputDecoration(hintText: 'Médecin traitant',labelText: 'Médecin traitant'),
          validator: (val)=> val.isEmpty? 'Médecin traitant obligatoire' : null,
          onChanged: (val){
            setState(() {
              _doc=val;
            });
          },
        ),
        SizedBox(height:10.0),
        TextFormField(
          initialValue: _emailValue??dispo.sasdispoPatientMail,
          decoration: InputDecoration(hintText: 'Mail ou identité du  patient',labelText: 'Mail ou identité du patient'),
          validator: (val)=> val.isEmpty? 'Entrer un Email ou une Identité' : null,
          onChanged: (val){
            setState(() {
              _emailValue=val;
            });
          },
        ),
        SizedBox(height:10.0),
        TextFormField(
          initialValue: _obs??dispo.sasdispoTxt,
          decoration: InputDecoration(hintText: 'Observation médicale',labelText: 'Observation médicale'),
          validator: (val)=> val.isEmpty? 'Saisir observation' : null,
          onChanged: (val){
            setState(() {
              _obs=val + ' - merci de compléter...';
            });
          },
          maxLines: 4,
        ),
        SizedBox(height:10.0),
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Je confirme la réalisation de cet acte. Je complète la synthèse',
          style: TextStyle(fontSize: 10.0),
          maxLines: 2,
          ),
          Checkbox(
            value: _flag??dispo.sasdispoReal, 
            onChanged: (val){
              setState(() {
                _flag = val;
              });
            }
          ),
        ],),
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
                _emailValue??dispo.sasdispoPatientMail, 
                _flag, 
                _doc??dispo.sasdispoPatientMt, 
                _obs, 
                dispo.sasdispoAffaire
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