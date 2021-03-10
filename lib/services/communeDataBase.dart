//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//Srevice de connexion à la base des communes du SAS
//SAS MANAGER v0.1.5

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sasprojectv1/models/commune.dart';
import 'package:uuid/uuid.dart';

class CommuneDataBaseService{

  final String comuid;
  CommuneDataBaseService({this.comuid});

  final uuid = Uuid();

  //Collection de toutes les communes
  final CollectionReference communeCollection = FirebaseFirestore.instance.collection('communes');

  //commune Data from Snapshot
  Commune _communeDataFromSnapshot(DocumentSnapshot snapshot){
    return Commune(
      uid: comuid,
      nom: snapshot.get('nom'),
      code: snapshot.get('code'),
      codeDepartement: snapshot.get('codeDepartement'),
      codeRegion: snapshot.get('codeRegion'),
      codePostal: snapshot.get('codePostal'),
      sasSecteur: snapshot.get('sasSecteur')
    );
  }

  Stream<Commune> get communeData{
    return communeCollection.doc(comuid).snapshots().map(_communeDataFromSnapshot);
  }

}