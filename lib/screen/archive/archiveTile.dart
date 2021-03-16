import 'package:flutter/material.dart';
import 'package:sasprojectv1/models/effector.dart';
import 'package:sasprojectv1/models/sasdispo.dart';
import 'package:sasprojectv1/screen/dispo/dispoconfirm.dart';
import 'package:sasprojectv1/services/dispoDataBase.dart';

class ArchiveTile extends StatelessWidget {

  final Sasdispo dispo;
  final Effector actualuser;
  ArchiveTile({this.dispo,this.actualuser});
  @override
  Widget build(BuildContext context) {

    Color _setColor(){
      if(dispo.sasdispoReal){
        return Colors.indigo[100];
      }else{
        return Colors.red[100];
      }
    }

    String _tag(){
      if(dispo.sasdispoReal){
        return 'Consultation réalisée';
      }else{
        return 'Consultation non consommée ou patient pas venu';
      }
    }

    return Padding(
      padding: EdgeInsets.only(top:8.0),
      child: Card(
        color: _setColor(),
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
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 70.0,),
                Text('Affaire SAMU: '+dispo.sasdispoAffaire+' / '+dispo.sasdispoPatientMail, style: TextStyle(fontSize: 12.0,),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 70.0,),
                Text('Finalisation: '+_tag(), style: TextStyle(fontSize: 12.0,),),
              ],
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () async{
                    await DispoDatabaseService().deleteArchiveDispo(dispo);
                  }, 
                  child: Text('SUPPRIMER')
                ),
                SizedBox(width:20.0)
              ],
            ),
        ],),
      ),
    );
  }
}