import 'package:flutter/material.dart';

import 'package:sasprojectv1/models/effector.dart';
import 'package:sasprojectv1/screen/archive/archiveTile.dart';
import 'package:sasprojectv1/screen/tools/loading.dart';
import 'package:sasprojectv1/services/dispoDataBase.dart';
import 'package:sasprojectv1/models/sasdispo.dart';

class ArchiveList extends StatelessWidget {

  final Effector actualUser;
  ArchiveList({this.actualUser});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DispoDatabaseService().archives,
      builder: (context, snapshot) {

        List<Sasdispo> archives = snapshot.data;

        if(snapshot.hasData){
          return ListView.builder(
          itemCount: archives.length,
          itemBuilder: (context,index){
            return ArchiveTile(dispo: archives[index],actualuser: actualUser,);
        });
        }else{
          return Loading();
        } 
      }
    );
  }
}