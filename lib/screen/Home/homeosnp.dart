//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//SAS MANAGER v1.0.2

import 'package:flutter/material.dart';

import 'package:sasprojectv1/models/effector.dart';
import 'package:sasprojectv1/models/commune.dart';
import 'package:sasprojectv1/screen/dispo/dispolist.dart';

import 'package:sasprojectv1/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:sasprojectv1/screen/authenticate/account.dart';
import 'package:sasprojectv1/screen/archive/archive.dart';

class HomeOSNP extends StatefulWidget {

  final Effector actualuser;
  HomeOSNP({this.actualuser});

  @override
  _HomeOSNPState createState() => _HomeOSNPState(actualuser: actualuser);
}

class _HomeOSNPState extends State<HomeOSNP> {

  final Effector actualuser;
  _HomeOSNPState({this.actualuser});

  final AuthService _auth = AuthService();
  String _communeValue;
  String _secteurValue='';

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
              Navigator.push(context, 
              MaterialPageRoute(builder: (context){
                return Archives();
              })
              );
            },
            tooltip: "G??rer les archives",
            child: Icon(Icons.archive),
            backgroundColor: Colors.grey[600],
            heroTag: 'btnArchive',
          ),
          SizedBox(width:10.0),
          FloatingActionButton(
            onPressed: (){
              setState(() {
                _secteurValue='';
              });
            },
            tooltip: "Tout afficher",
            child: Icon(Icons.select_all),
            backgroundColor: Colors.indigo[900],
          ),
          SizedBox(width:10.0),
          FloatingActionButton(
            onPressed: () async {
              //on affiche une fen??tre de dialog
              return showDialog(context: context, 
              builder: (BuildContext context){
                return AlertDialog(
                title: Text('Choisir une commune'),
                content: DropdownButton(
                  value:_communeValue,
                  items: communeList.map((com){
                    return DropdownMenuItem(
                      value:com.nom,
                      child: Text(com.nom),
                    );
                  }).toList(),
                  onChanged: (val){
                    setState(() {
                      _communeValue=val;
                    });
                    for(var com in communeList){
                      if(_communeValue.compareTo(com.nom)==0){
                        setState(() {
                          _secteurValue = com.sasSecteur;
                        });
                      }
                    }
                    Navigator.pop(context);
                  },
                ),
              );
              }
              );
            },
            tooltip: 'Filtrer les disponibilit??s',
            child: Icon(Icons.search),
            heroTag: 'btnSearch',
          ),
        ],
      ),
      body: DispoListe(requestUser: actualuser,requestListInfo: _secteurValue,),
    );
  }
}