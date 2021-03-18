//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//SAS MANAGER v1.0.2

import 'package:flutter/material.dart';
import 'package:sasprojectv1/screen/tools/loading.dart';
import 'package:sasprojectv1/services/auth.dart';

class Register extends StatefulWidget {

  //fonction de callback pivotement authenticate/register
  final Function toggleId;
  Register({this.toggleId});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  //TextFields state
  String email='';
  String password='';
  String error='';

  @override
  Widget build(BuildContext context) {
    return loading?Loading():Scaffold(
      appBar: AppBar(
        title: Text('Créer un compte SASManager 73'),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           FloatingActionButton(
            onPressed: (){
              widget.toggleId();
            },
            tooltip: 'Connexion',
            child:Icon(Icons.login),
            backgroundColor: Colors.indigo[700],
          ),
          SizedBox(width:10.0,),
          FloatingActionButton(
            onPressed: ()async {
               if(_formKey.currentState.validate()){
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _authService.registerWithEmailAndPassword(email, password);
                    if (result == null){
                      setState(() {
                        loading = false;
                        error = 'Entrez un email valide';
                      });
                    }
                  }   
            },
            tooltip: 'Créer mot compte...',
            child: Icon(Icons.app_registration),
          ),
        ],
      ),
      body:Container(
        padding: const EdgeInsets.symmetric(vertical:20,horizontal:50),
        child: Form(
          key: _formKey,
          child:Column(
            children: <Widget>[
              SizedBox(height:20),
              TextFormField(
                decoration: InputDecoration(hintText: 'Email'),
                validator: (val) => val.isEmpty? 'Entrez votre Email' : null,
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height:20),
              TextFormField(
                decoration: InputDecoration(hintText: 'Mot de passe'),
                validator: (val) => val.length <6 ? 'Password au  moins 7 carractères' : null,
                obscureText: true,
                onChanged:  (val){
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height:20),
              Text(
                error,
                style: TextStyle(color: Colors.red,fontSize:14),
              )
            ],
            )
        ),
      ),
    );
  }
}