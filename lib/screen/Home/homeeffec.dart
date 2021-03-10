import 'package:flutter/material.dart';

import 'package:sasprojectv1/models/effector.dart';
import 'package:sasprojectv1/models/commune.dart';
import 'package:sasprojectv1/screen/dispo/dispolist.dart';

import 'package:sasprojectv1/services/auth.dart';
import 'package:provider/provider.dart';

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

    return Scaffold(
      appBar: AppBar(
        title:Text(actualuser.effectorName+' - '+actualuser.effectorRole,style: TextStyle(fontSize: 12.0),),
        actions: [
          TextButton.icon(
            onPressed: (){}, 
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
          ),
          SizedBox(width: 10.0,),
          FloatingActionButton(
            onPressed: (){},
            tooltip: 'Créer une disponibilité',
            child: Icon(Icons.event),
          ), 
        ],
      ),
      body: DispoListe(requestUser: actualuser,requestListInfo: _secteurValue,),
    );
  }
}