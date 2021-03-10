//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//Srvice de gestion de la base des disponibilités SAS
//SAS MANAGER v0.1.5

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import 'package:sasprojectv1/models/sasdispo.dart';

class DispoDatabaseService{

  final String sasdispoId;
  final String request;
  final String requestInfo;
  
  DispoDatabaseService({this.sasdispoId,this.request,this.requestInfo});

  final uuidgen = Uuid();

  //Collection de toutes les dispos
  final CollectionReference dispoCollection = FirebaseFirestore.instance.collection('dispos');

  //Collection des dispos archivées
  final CollectionReference archiveCollection = FirebaseFirestore.instance.collection('archives');

  //Création, update d'une dispo
  Future updateDispoData(String sasdispoId,String sasdispoSecteur,DateTime sasdispoDeb,DateTime sasdispoEnd,String sasdispoEffectorName,String sasdispoEffectorId,
  String sasdispoEffectorSpe,String sasdispoType,String sasdispoPatientMail,bool sasdispoReal,String sasdispoPatientMt,String sasdispoTxt,String sasdispoAffaire) async {
  
  if(sasdispoId==''){
    sasdispoId = uuidgen.v4().toString();
  }


  return dispoCollection.doc(sasdispoId).set({
    'sasdispoId':sasdispoId,
    'sasdispoSecteur':sasdispoSecteur,
    'sasdispoDeb':sasdispoDeb,
    'sasdispoEnd':sasdispoEnd,
    'sasdispoEffectorName':sasdispoEffectorName,
    'sasdispoEffectorId':sasdispoEffectorId,
    'sasdispoEffectorSpe':sasdispoEffectorSpe,
    'sasdispoType':sasdispoType,
    'sasdispoPatientMail':sasdispoPatientMail,
    'sasdispoReal':sasdispoReal,
    'sasdispoPatientMt':sasdispoPatientMt,
    'sasdispoTxt':sasdispoTxt,
    'sasdispoAffaire':sasdispoAffaire
  });

  }

  //Liste des dispo à partir d'un snapshot
  List<Sasdispo> _sasdispoListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      
      Timestamp t = doc['sasdispoDeb'];
      DateTime d = t.toDate();
      
      t = doc['sasdispoEnd'];
      DateTime e = t.toDate();
    
      return Sasdispo(
        sasdispoId: doc['sasdispoId'],
        sasdispoSecteur:doc['sasdispoSecteur'],
        sasdispoDeb: d,
        sasdispoEnd: e,
        sasdispoEffectorName: doc['sasdispoEffectorName'],
        sasdispoEffectorId: doc['sasdispoEffectorId'],
        sasdispoEffectorSpe: doc['sasdispoEffectorSpe'],
        sasdispoType: doc['sasdispoType'],
        sasdispoPatientMail: doc['sasdispoPatientMail'],
        sasdispoReal: doc['sasdispoReal'],
        sasdispoPatientMt: doc['sasdispoPatientMt'],
        sasdispoTxt: doc['sasdispoTxt'],
        sasdispoAffaire: doc['sasdispoAffaire'],
      );
    }).toList();
  }

  //List des dispo filtrée avec le secteur
  List<Sasdispo> _sasdispoListFromSnapshotParSecteur(QuerySnapshot snapshot){

  List<Sasdispo> _result = [];

  for (var doc in snapshot.docs){
   
    if(requestInfo.compareTo(doc['sasdispoSecteur'])==0){
      
      Timestamp t = doc['sasdispoDeb'];
      DateTime d = t.toDate();
    
      t = doc['sasdispoEnd'];
      DateTime e = t.toDate();

      Sasdispo _dispo = Sasdispo(
      sasdispoId: doc['sasdispoId'],
      sasdispoSecteur:doc['sasdispoSecteur'],
      sasdispoDeb: d,
      sasdispoEnd: e,
      sasdispoEffectorName: doc['sasdispoEffectorName'],
      sasdispoEffectorId: doc['sasdispoEffectorId'],
      sasdispoEffectorSpe: doc['sasdispoEffectorSpe'],
      sasdispoType: doc['sasdispoType'],
      sasdispoPatientMail: doc['sasdispoPatientMail'],
      sasdispoReal: doc['sasdispoReal'],
      sasdispoPatientMt: doc['sasdispoPatientMt'],
      sasdispoTxt: doc['sasdispoTxt'],
      sasdispoAffaire: doc['sasdispoAffaire']
    );

      _result.add(_dispo);
    }
  }
  return _result;
  }

  //List des dispo filtrée par effecteur
  List<Sasdispo> _sasdispoListFromSnapshotParEffecteur(QuerySnapshot snapshot){

  List<Sasdispo> _result = [];

  for (var doc in snapshot.docs){
   
    if(requestInfo.compareTo(doc['sasdispoEffectorId'])==0){
      
      Timestamp t = doc['sasdispoDeb'];
      DateTime d = t.toDate();
    
      t = doc['sasdispoEnd'];
      DateTime e = t.toDate();

      Sasdispo _dispo = Sasdispo(
      sasdispoId: doc['sasdispoId'],
      sasdispoSecteur:doc['sasdispoSecteur'],
      sasdispoDeb: d,
      sasdispoEnd: e,
      sasdispoEffectorName: doc['sasdispoEffectorName'],
      sasdispoEffectorId: doc['sasdispoEffectorId'],
      sasdispoEffectorSpe: doc['sasdispoEffectorSpe'],
      sasdispoType: doc['sasdispoType'],
      sasdispoPatientMail: doc['sasdispoPatientMail'],
      sasdispoReal: doc['sasdispoReal'],
      sasdispoPatientMt: doc['sasdispoPatientMt'],
      sasdispoTxt: doc['sasdispoTxt'],
      sasdispoAffaire: doc['sasdispoAffaire']
    );
      _result.add(_dispo);
    }
  }
  return _result;
  }

  Stream<List<Sasdispo>> get sasdispoliste{

    switch(request){
      case 'sassector':
        return dispoCollection.orderBy('sasdispoDeb').snapshots().map(_sasdispoListFromSnapshotParSecteur);
        break;
      case 'saseffector':
      return dispoCollection.orderBy('sasdispoDeb').snapshots().map(_sasdispoListFromSnapshotParEffecteur); 
        break;
      default:
        return dispoCollection.orderBy('sasdispoDeb').snapshots().map(_sasdispoListFromSnapshot);
    }
  }

  //Suppression d'une dispo
  Future deleteSasDispo(Sasdispo dispo) async {
    return dispoCollection.doc(dispo.sasdispoId).delete();
  }

  //Archivage d'une dispo
  Future archiverDispo(Sasdispo dispo) async {

    await deleteSasDispo(dispo);

    return archiveCollection.doc(dispo.sasdispoId).set({
    'sasdispoId':dispo.sasdispoId,
    'sasdispoSecteur':dispo.sasdispoSecteur,
    'sasdispoDeb':dispo.sasdispoDeb,
    'sasdispoEnd':dispo.sasdispoEnd,
    'sasdispoEffectorName':dispo.sasdispoEffectorName,
    'sasdispoEffectorId':dispo.sasdispoEffectorId,
    'sasdispoEffectorSpe':dispo.sasdispoEffectorSpe,
    'sasdispoType':dispo.sasdispoType,
    'sasdispoPatientMail':dispo.sasdispoPatientMail,
    'sasdispoReal':dispo.sasdispoReal,
    'sasdispoPatientMt':dispo.sasdispoPatientMt,
    'sasdispoTxt':dispo.sasdispoTxt,
    'sasdispoAffaire':dispo.sasdispoAffaire
    });
  }

}