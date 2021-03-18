//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//SAS MANAGER v1.0.2

import 'package:flutter/material.dart';

import 'package:sasprojectv1/models/effector.dart';
import 'package:sasprojectv1/models/commune.dart';
import 'package:sasprojectv1/screen/dispo/dispolist.dart';
import 'package:sasprojectv1/screen/dispo/newdispo.dart';

import 'package:sasprojectv1/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:sasprojectv1/screen/authenticate/account.dart';

class HomeEFFEC extends StatefulWidget {

  final Effector actualuser;
  HomeEFFEC({this.actualuser});

  @override
  _HomeEFFECState createState() => _HomeEFFECState(actualuser: actualuser);
}

class _HomeEFFECState extends State<HomeEFFEC> {

  final Effector actualuser;
  _HomeEFFECState({this.actualuser});

  final AuthService _auth = AuthService();
  
  String _secteurValue='MEFFEC';

  @override
  Widget build(BuildContext context) {

    List<Commune> communeList = Provider.of<List<Commune>>(context);

    return Scaffold(
      appBar: AppBar(
        title:Text(actualuser.effectorName+' - '+actualuser.effectorRole,style: TextStyle(fontSize: 12.0),),
        actions: [
          TextButton.icon(
            onPressed: (){
              Navigator.push(context, 
              MaterialPageRoute(builder: (context){
                return UserAccount(actualUser: actualuser,commmunes: communeList,);
              })
              );
            }, 
            icon: Icon(Icons.settings,color: Colors.white,), 
            label: Text('Mon compte',style: TextStyle(color: Colors.white),)
            ),
          SizedBox(width:10.0),
          TextButton.icon(
            onPressed: () async {
              await _auth.signOut();
            }, 
            icon: Icon(Icons.logout,color: Colors.white,), 
            label: Text(''),
          ),
          SizedBox(width: 10.0,),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: (){
              setState(() {
                _secteurValue='MEFFEC-ALL';
              });
            },
            tooltip: "Voir les disponibilités de mon secteur",
            child: Icon(Icons.select_all),
            backgroundColor: Colors.indigo[600],
            heroTag: 'btnMySector',
          ),
          SizedBox(width: 10.0,),
          FloatingActionButton(
            onPressed: (){
              setState(() {
                _secteurValue='MEFFEC';
              });
            },
            tooltip: 'Voir mes disponibilité',
            child: Icon(Icons.visibility),
            backgroundColor: Colors.indigo[800],
            heroTag: 'btnMy',
          ),
          SizedBox(width: 10.0,),
          FloatingActionButton(
            onPressed: (){
              Navigator.push(context, 
              MaterialPageRoute(builder: (context){
                return NewDispoPlanning(actualEffector: actualuser,);
              })
              );
            },
            tooltip: 'Créer une disponibilité',
            child: Icon(Icons.event),
            heroTag: 'btnNewDispo',
          ), 
        ],
      ),
      body: DispoListe(requestUser: actualuser,requestListInfo: _secteurValue,),
    );
  }
}