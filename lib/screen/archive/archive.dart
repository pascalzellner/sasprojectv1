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