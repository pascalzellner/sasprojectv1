import 'package:flutter/material.dart';

import 'package:sasprojectv1/models/effector.dart';
import 'package:sasprojectv1/screen/tools/loading.dart';
import 'package:sasprojectv1/services/dispoDataBase.dart';
import 'package:sasprojectv1/models/sasdispo.dart';
import 'package:sasprojectv1/screen/dispo/dispotile.dart';

class DispoListe extends StatelessWidget {

  final Effector requestUser;
  final String requestListInfo;
  DispoListe({this.requestUser,this.requestListInfo});

 

  @override
  Widget build(BuildContext context) {

  String _requestType;
  String _requestInfo;

  print(requestUser.effectorRole);

    switch(requestUser.effectorRole){
        //si le user est un MEFFEC (médecin effecteur)
        case'MEFFEC':
        switch(requestListInfo){
          case'MEFFEC':
          _requestType='saseffector';
          _requestInfo=requestUser.effectorId;
          break;
          case'MEFFEC-ALL':
          _requestType='sassector';
          _requestInfo=requestUser.sasSectorName;
          break;
          //le user n'est pas MEFFEC il peut voir tous les secteurs
          default:
        }
        break;
        default:
        
          switch(requestListInfo){
            //si request info = '' on veut voir toutes les dispos
            case'':
            _requestType='';
            _requestInfo='';
            break;
            default:
            _requestType = 'sassector';
            _requestInfo = requestListInfo;
          }
    }
    print(_requestType);
    print(_requestInfo);
    return StreamBuilder(
      stream: DispoDatabaseService(sasdispoId: '',request: _requestType,requestInfo:_requestInfo).sasdispoliste,
      builder: (context,snapshot){
        if(snapshot.hasData){

          List<Sasdispo> myDispo = snapshot.data;

            return ListView.builder(
            itemCount: myDispo.length,
            itemBuilder: (context,index){
            return DispoTile(dispo: myDispo[index],actualUser: requestUser,);
            }

          );
        }else{
          return Loading();   
        }
      }
    );
  }
}