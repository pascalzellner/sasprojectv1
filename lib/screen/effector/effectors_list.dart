//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//SAS MANAGER v1.0.2

import 'package:flutter/material.dart';
import 'package:sasprojectv1/models/effector.dart';
import 'package:sasprojectv1/screen/tools/loading.dart';
import 'package:sasprojectv1/services/database.dart';
import 'effector_tile.dart';

class EffectorsList extends StatefulWidget {

  @override
  _EffectorsListState createState() => _EffectorsListState();
}

class _EffectorsListState extends State<EffectorsList> {

  @override
  Widget build(BuildContext context) {

   return StreamBuilder<List<Effector>>(
     stream: DataBaseService().effectors,
     builder: (context, snapshot) {

       if(snapshot.hasData){

         List<Effector> effecteurs = snapshot.data;

         return Scaffold(
          appBar: AppBar(
             title: Text('Gestion des utilisateurs'),
          ),
          body: ListView.builder(
            itemCount: effecteurs.length,
            itemBuilder: (context,index){
              return EffectorTile(effector: effecteurs[index],);
            }
          ), 
       );
       }else{
         return Loading();
       }   
     }
   );
  
  }
}