import 'package:flutter/material.dart';
import 'package:sasprojectv1/models/sasdispo.dart';
import 'package:sasprojectv1/models/effector.dart';
import 'package:sasprojectv1/services/dispoDataBase.dart';
import 'package:sasprojectv1/services/database.dart';
import 'package:sasprojectv1/screen/dispo/dispoconfirm.dart';
import 'package:sasprojectv1/screen/dispo/disporesa.dart';

class DispoTile extends StatelessWidget {

  final Sasdispo dispo;
  final Effector actualUser;
  DispoTile({this.dispo,this.actualUser});

  @override
  Widget build(BuildContext context) {

    //pop up des messages d'alerte
    void _showAlert(String message){
      showModalBottomSheet(context: context, 
      builder: (context){
        return Container(
          color: Colors.red[100],
          padding: EdgeInsets.symmetric(vertical:20, horizontal:60.0),
          child: Center(child: Text(message)),
        );
      }
      );
    }

    void _archiver() async {
      await DispoDatabaseService().archiverDispo(dispo);
    }

    //paramétrage de la couleur de la carte en fct du statut de la dispo
    Color _tileColor(){
      Color selectColor;

      if(dispo.sasdispoPatientMail.compareTo('LIBRE')==0){
        selectColor = Colors.green[100];
      } else {
        if(dispo.sasdispoReal == false){
          selectColor = Colors.red[100];
        }else{
          selectColor = Colors.blue[100];
        }
      }
      if(dispo.sasdispoEnd.compareTo(DateTime.now())<0){
        selectColor=Colors.orange[100];
      }
      return selectColor;
    }

    //paramètre les libellés de boutons en fct du statut de la dispo et du user connecté
    String _btnInfo(){
      String _info;
       if(dispo.sasdispoPatientMail.compareTo('LIBRE')==0){
        _info='RESERVER';
      } else {
        if(dispo.sasdispoReal == false){
          _info='ANNULER';
        }else{
          _info='ARCHIVER';
        }
      }
      if(dispo.sasdispoEnd.compareTo(DateTime.now())<0){
        _info='ARCHIVER';
      }
      return _info;
    }

    //paramètre l'affichage des boutons en fct du contexte
    Row _boutons(){
      switch(_btnInfo()){
        case'ANNULER':
        return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 20.0,),
                TextButton(
                  onPressed: () async {
                    //on annule la consultation , on enlève le patient mais pas la dispo
                    DispoDatabaseService().updateDispoData(
                      dispo.sasdispoId, 
                      dispo.sasdispoSecteur, 
                      dispo.sasdispoDeb, 
                      dispo.sasdispoEnd, 
                      dispo.sasdispoEffectorName, 
                      dispo.sasdispoEffectorId, 
                      dispo.sasdispoEffectorSpe, 
                      dispo.sasdispoType, 
                      'LIBRE', 
                      false, 
                      '', 
                      '',
                      'NP'
                    );
                  },
                  child: Text(_btnInfo()),
                ),
                SizedBox(width:20),
                TextButton(
                  onPressed: () {
                    //on affiche le questionnaire de consultation si c'est le bon user qui est connecté, identification via le token
                    if(actualUser.effectorId.compareTo(dispo.sasdispoEffectorId)==0){
                      showModalBottomSheet(context: context, 
                      builder: (context){
                        return Container(
                          color: Colors.blueGrey[100],
                          padding: EdgeInsets.symmetric(vertical:20, horizontal:60.0),
                          child: DispoConsultation(dispo: dispo,),
                        );
                        }
                      );
                    }else{
                      _showAlert('Accès interdit, effecteurID incorrecte !');
                    }
                  },
                  child: Text('REALISER'),
                ),
                SizedBox(width:20)
              ],
            );
        break;
        default:
        return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 20.0,),
                TextButton(
                  onPressed: () {
                    switch(_btnInfo()){
                      case'RESERVER':
                      showModalBottomSheet(context: context, 
                      builder: (context){
                        return Container(
                          color: Colors.blueGrey[100],
                          padding: EdgeInsets.symmetric(vertical:20, horizontal:60.0),
                          child: ResaForm(dispo: dispo,),
                        );
                        }
                      );
                      break;
                      case'ARCHIVER':
                       _archiver();
                      break;
                      default:
                    }
                  },
                  child: Text(_btnInfo()),
                ),
                SizedBox(width:20),
              ],
            );
      }
    }

    
    
    return Padding(
      padding: EdgeInsets.only(top:8.0),
      child: Card(
        color: _tileColor(),
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: Column(children: [
          ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueGrey,
                child: Icon(Icons.date_range),
              ),
              title: Text(dispo.sasdispoEffectorName + ' ' + dispo.sasdispoEffectorSpe),
              subtitle: Text(dispo.sasdispoDeb.toString() + ' - ' + dispo.sasdispoPatientMail),
            ),
            StreamBuilder<Effector>(
              stream: DataBaseService(uid: dispo.sasdispoEffectorId).effectorData,
              builder: (context, snapshot) {

                if (snapshot.hasData){
                  Effector effecteur = snapshot.data;
                  return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 70.0,),
                    Text('Adresse: '+effecteur.effectorAddress + ' - '+effecteur.effectorCP + ' / ' + effecteur.effectorCommune, style: TextStyle(fontSize: 10.0,),),
                  ],
                );
                }else{
                  return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 70.0,),
                    Text('chargement...', style: TextStyle(fontSize: 10.0,),),
                  ],
                );
                }    
              }
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 70.0,),
                Text('Secteur SAS: '+dispo.sasdispoSecteur + ' / '+dispo.sasdispoType, style: TextStyle(fontSize: 12.0,),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 70.0,),
                Text(dispo.sasdispoEffectorId, style: TextStyle(fontSize: 10.0, color: Colors.grey),),
              ],
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 70.0,),
                Text('réf SAS: '+dispo.sasdispoAffaire, style: TextStyle(fontSize: 10.0, color: Colors.grey),),
              ],
            ),
            _boutons(),
        ],),
      ),
      
    );
  }
}