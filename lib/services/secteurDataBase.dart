//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//Service de gestion de la base des secteurs
//SAS MANAGER v0.1.5

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sasprojectv1/models/secteur.dart';
import 'package:uuid/uuid.dart';

class SecteurDataBaseService {

  final String sectorId;
  SecteurDataBaseService({this.sectorId});

  final uuidgen = Uuid();

  //Collection de toutes les communes
  final CollectionReference secteurCollection = FirebaseFirestore.instance.collection('secteurs');

  //Création , update d'un secteur
  Future updateSecteurData(String uuid,String nom) async {
    if (uuid ==''){
      uuid = uuidgen.v4().toString();
    }
    return secteurCollection.doc(uuid).set({
      'uuid':uuid,
      'nom': nom,
    }
    );
  }

   //Création liste de secteur à partir d'un snapshot de la base
  List<Secteur> _secteurListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Secteur(
        uuid: doc['uuid'],
        nom: doc['nom']
      );
    }).toList();
  }

  //Stream qui donne accés à la liste des secteurs
  Stream<List<Secteur>> get secteurs {
    try{
      return secteurCollection.snapshots().map(_secteurListFromSnapshot);
    }catch(e){
      
      return null;
    }
    
  }

  //Secteur à partir d'un snapshot
  Secteur _secteurFromSnapshot(DocumentSnapshot snapshot){
    return Secteur(
      uuid: snapshot.get('uuid'),
      nom: snapshot.get('nom')
    );
  }

  //Stream qui renvoie un secteur
  Stream<Secteur> get secteurData{
    try{
      return secteurCollection.doc(sectorId).snapshots().map(_secteurFromSnapshot);
    }catch(e){
      
      return null;
    }
    
  }
}