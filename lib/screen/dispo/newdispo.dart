//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//SAS MANAGER v1.0.2

import 'package:flutter/material.dart';
import 'package:sasprojectv1/models/effector.dart';
import 'package:sasprojectv1/services/dispoDataBase.dart';

import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class NewDispoPlanning extends StatefulWidget {
  final Effector actualEffector;
  NewDispoPlanning({this.actualEffector});
  @override
  _NewDispoPlanningState createState() => _NewDispoPlanningState(actualEffector: actualEffector);
}

class _NewDispoPlanningState extends State<NewDispoPlanning> {
  final Effector actualEffector;
  _NewDispoPlanningState({this.actualEffector});

  final _formKey = GlobalKey<FormState>();

  DateTime _currentDispoDeb = DateTime.now();
  DateTime _currentDispoEnd = DateTime.now();
  String _currentDispoDebString = 'Date et heure de début';
  String _currentDispoEndString = 'Date et heure de fin';

  String _currentType = 'Consultation';
  List<String> typeC = ['Consultation','Téléconsultation','Visite à domicile'];

  String _error = '';

  @override
  Widget build(BuildContext context) {

    void _showConfirmationPanel(Effector my){
      showModalBottomSheet(context: context, 
      builder: (context){
        return Container(
          color: Colors.red[100],
          padding: EdgeInsets.symmetric(vertical:20, horizontal:60.0),
          child: Card(
            color: Colors.red[200],
            margin: EdgeInsets.fromLTRB(5, 6, 5, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height:10.0),
                ListTile(
                  leading: Icon(Icons.check),
                  title : Text('Confirmation de disponibilité', style: TextStyle(color: Colors.red),),
                  subtitle: Text('Attention vous allez confimer une '+_currentType+ ' début: '+_currentDispoDebString+' fin: '+_currentDispoEndString+ ' qui sera incérée dans les dispos du SAS pour votre secteur'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: 20.0,),
                    TextButton(
                      onPressed: () async {
                        await DispoDatabaseService().updateDispoData(
                          //sasdispoId
                          '',
                          my.sasSectorName, 
                          _currentDispoDeb, 
                          _currentDispoEnd, 
                          my.effectorName, 
                          my.effectorId, 
                          my.effectorSpe,
                          _currentType, 
                          //sasdispoPatientMail
                          'LIBRE', 
                          //sasdispoReal
                          false,
                          //médecin traitant
                          'INCONNU',
                          //sasdispoTxt,
                          '',
                          //sasdispoAffaire
                          'NP',
                        );
                        //todo penser à implémenter le compteur de plage donnée
                        setState(() {
                          _currentDispoDeb = DateTime.now();
                          _currentDispoEnd = DateTime.now();
                          _currentDispoDebString = 'Date et heure de début';
                          _currentDispoEndString = 'Date et heure de fin';
                        });
                        Navigator.pop(context);
                      },
                      child: Text('Je vais assurer cette disponibilité', style: TextStyle(color: Colors.white),),
                    ),
                    SizedBox(width:20),
                  ],
                ),
              ],
            ),
          ),
        );
      }
      );
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('Nouvelle Disponibilité'),
        backgroundColor: Colors.orange[300],
      ),
      body: Center(
              child: Column(
                children: [
                  Form(
                    key:_formKey,
                    child:Column(
                      children: [
                        //Sélection Date et heure de début
                        Card(
                          color: Colors.blue[100],
                          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: Icon(Icons.schedule),
                                title: Text(_currentDispoDebString),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(height: 20.0,),
                                  TextButton(
                                    onPressed: (){
                                          DatePicker.showDateTimePicker(context,
                                          showTitleActions: true,
                                          minTime: DateTime(2021,2,1),
                                          maxTime: DateTime(2021,12,30),
                                          onChanged: (date){},
                                          onConfirm: (date){setState(() {
                                            _currentDispoDeb = date;
                                            _currentDispoDebString=_currentDispoDeb.toString();
                                            print(_currentDispoDebString);
                                          });},
                                          currentTime: DateTime.now(),locale: LocaleType.fr,
                                        );
                                    },
                                    child: Text('DEFINIR'),
                                  ),
                                  SizedBox(width:20),
                                ],
                              ),
                            ],
                          ),
                        ),
                        //Sélection Date et heur de fin
                        Card(
                          color: Colors.blue[100],
                          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: Icon(Icons.schedule),
                                title: Text(_currentDispoEndString),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(height: 20.0,),
                                  TextButton(
                                    onPressed: (){
                                          DatePicker.showDateTimePicker(context,
                                          showTitleActions: true,
                                          minTime: DateTime(2021,2,1),
                                          maxTime: DateTime(2021,12,30),
                                          onChanged: (date){},
                                          onConfirm: (date){
                                            setState(() {
                                              _currentDispoEnd = date;
                                              _currentDispoEndString = _currentDispoEnd.toString();
                                              print(_currentDispoEndString);
                                            });
                                          },
                                          currentTime: _currentDispoDeb ,locale: LocaleType.fr,
                                        );
                                    },
                                    child: Text('DEFINIR'),
                                  ),
                                  SizedBox(width:20),
                                ],
                              ),
                            ],
                          ),
                        ),
                        //Sélection du type de dispo
                        Card(
                          color: Colors.green[100],
                          margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: Icon(Icons.preview),
                                title:DropdownButtonFormField(
                                  value:_currentType,
                                  decoration: InputDecoration(hintText: 'Type de consultation'),
                                  items : typeC.map((doc){
                                    return DropdownMenuItem(child: Text(doc),value: doc,);
                                  }).toList(),
                                  onChanged: (val){
                                    setState(() {
                                      _currentType = val;
                                      print(_currentType);
                                    });
                                  },
                                )
                              ),
                              SizedBox(height: 15.0,),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.0,),
                        ElevatedButton(
                          onPressed: (){
                            //int test = _currentDispoDebString.compareTo('Date et heure de début');
                            if (_currentDispoDebString.compareTo('Date et heure de début') == 0){
                              setState(() {
                                _error = 'Préciser début, fin et type de disponibilité !';
                              });
                            }else{
                              if(_currentDispoEndString.compareTo('Date et heure de fin')==0){
                                 setState(() {
                                _error = 'Préciser début, fin et type de disponibilité !';
                                });
                              }else{
                                if(actualEffector.sasSectorName.compareTo('NP')==0){
                                  setState(() {
                                    _error='Commune non paramétrée, contacter un administrateur';
                                  });
                                }else{
                                  setState(() {
                                  _error = '';
                                  });
                                  _showConfirmationPanel(actualEffector);
                                }  
                              }
                            }
                          },
                          child: Text('Valider la disponibilité'),
                        ),
                        SizedBox(height: 20.0,),
                        Text(_error,style: TextStyle(color: Colors.pinkAccent),)
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}