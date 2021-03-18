//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//SAS MANAGER v1.0.2

import 'package:flutter/material.dart';
import 'package:sasprojectv1/screen/archive/archiveList.dart';
import 'package:sasprojectv1/models/effector.dart';

class Archives extends StatelessWidget {

  final Effector actualUser;
  Archives({this.actualUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestion des archives'),
      ),
      body:ArchiveList(actualUser:actualUser,)
    );
  }
}