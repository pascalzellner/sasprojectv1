//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//Moddule du splash screen
//SAS MANAGER v0.1.5

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[100],
      child: Center(
        child: SpinKitChasingDots(
          color:Colors.orange,
          size:50,
        ),
      ),
    );
  }
}