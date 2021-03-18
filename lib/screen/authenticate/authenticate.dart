//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//SAS MANAGER v1.0.2

import 'package:flutter/material.dart';
import 'package:sasprojectv1/screen/authenticate/signin.dart';
import 'package:sasprojectv1/screen/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  //flag de pivotement entre création et connexion
  bool showSignIn = true;
  void toggleId(){
   setState(()=> showSignIn=!showSignIn);
  }

  @override
  Widget build(BuildContext context) {
   if(showSignIn){
     return SignIn(toggleId: toggleId);
   }else{
     return Register(toggleId: toggleId);
   }
  }
}