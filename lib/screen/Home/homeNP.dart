//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//SAS MANAGER v1.0.2

import 'package:flutter/material.dart';
import 'package:sasprojectv1/models/effector.dart';
import 'package:sasprojectv1/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:sasprojectv1/models/commune.dart';
import 'package:sasprojectv1/screen/authenticate/account.dart';
import 'package:sasprojectv1/screen/Home/homeredirect.dart';

class HomeNP extends StatefulWidget {
  final Effector actualUser;
  HomeNP({this.actualUser});

  @override
  _HomeNPState createState() => _HomeNPState(actualUser: actualUser);
}

class _HomeNPState extends State<HomeNP> {

  final Effector actualUser;
  _HomeNPState({this.actualUser});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    
    List<Commune> communeList = Provider.of<List<Commune>>(context);

    return Scaffold(
      appBar: AppBar(
        title:Text(actualUser.effectorName+' - '+actualUser.effectorRole,style: TextStyle(fontSize: 12.0),),
        actions: [
          TextButton.icon(
            onPressed: (){
              Navigator.push(context, 
              MaterialPageRoute(builder: (context){
                return UserAccount(actualUser: actualUser,commmunes: communeList,);
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
                return HomeRedirect(actualUser: actualUser,);
              })
              );
            },
            tooltip: "Commencer",
            child: Icon(Icons.not_started),
            backgroundColor: Colors.indigo[900],
          ),
          SizedBox(width:10.0),
          
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top:8.0),
        child: Card(
           margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
           color: Colors.orange[900],
           child:ListTile(
             title: Text('Première utilisation',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
             subtitle: Text('Finalisez votre compte, en cliquant sur mon compte',style: TextStyle(color: Colors.white),),
           ),
        ),
      ),
    );
  }
}