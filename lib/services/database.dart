//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//Service de gestion de la base , fct de base
//SAS MANAGER v0.1.5


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sasprojectv1/models/commune.dart';
import 'package:sasprojectv1/models/effector.dart';
import 'package:sasprojectv1/services/apigouv.dart';
import 'package:uuid/uuid.dart';


class DataBaseService {

  final String uid;
  DataBaseService({this.uid});

  //Collection de tous les utilisateurs, effecteurs
  final CollectionReference effectorCollection = FirebaseFirestore.instance.collection('effectors');

  //Collection de toutes les communes
  final CollectionReference communeCollection = FirebaseFirestore.instance.collection('communes');

  //Collection de la liste des secteurs SAS
  final CollectionReference secteurCollection = FirebaseFirestore.instance.collection("secteurs");

  //générateur uuid
  final uuid = Uuid();
  

  //Création , update d'un effecteur
  Future updateEffectorData (String sasSectorName, String sasSectorId, String effectorRole, String effectorName, String effectorSpe, String effectorType, String effectorCommune, String effectorCP, String effectorAddress, String effectorRPPS, String effectorSector,int effectorAppNb) async {
    
    print(effectorCommune);

    return  effectorCollection.doc(uid).set({
      'sasSectorName':sasSectorName,
      'sasSectorId':sasSectorId,
      'effectorId':uid,
      'effectorRole': effectorRole,
      'effectorName':effectorName,
      'effectorCommune': effectorCommune,
      'effectorCP': effectorCP,
      'effectorAddress':effectorAddress,
      'effectorRPPS':effectorRPPS,
      'effectorSpe':effectorSpe,
      'effectorSector':effectorSector,
      'effectorAppNb':effectorAppNb,
    });
  }

  //list d'effector à partir du Snapshot
  List<Effector> _effectorListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Effector(
        sasSectorName: doc['sasSectorName'] ?? '',
        sasSectorId: doc['sasSectorId'] ?? '',
        effectorId: doc['effectorId'] ?? '',
        effectorRole: doc['effectorRole'] ?? '',
        effectorName: doc['effectorName'] ?? '',
        effectorCommune: doc['effectorCommune'] ?? '',
        effectorCP: doc['effectorCP'] ?? '',
        effectorAddress: doc['effectorAddress'] ?? '',
        effectorRPPS: doc['effectorRPPS'] ?? '',
        effectorSpe: doc['effectorSpe'] ?? '',
        effectorSector: doc['effectorSector'] ?? '',
        effectorAppNb: doc['effectorAppNb'] ?? 0
      );
    }).toList();
  }

  //Stream qui donne accès à la liste des effector
  Stream<List<Effector>> get effectors {
    return effectorCollection.orderBy('effectorName').snapshots().map(_effectorListFromSnapshot);
  }

 
  Effector _effectorFromSnapshot(DocumentSnapshot snapshot){
    return Effector(
      sasSectorName: snapshot.get('sasSectorName'),
      sasSectorId: snapshot.get('sasSectorId'),
      effectorId: snapshot.get('effectorId'),
      effectorRole: snapshot.get('effectorRole'),
      effectorName: snapshot.get('effectorName'),
      effectorCommune: snapshot.get('effectorCommune'),
      effectorAddress: snapshot.get('effectorAddress'),
      effectorRPPS: snapshot.get('effectorRPPS'),
      effectorSpe: snapshot.get('effectorSpe'),
      effectorCP: snapshot.get('effectorCP'),
      effectorSector: snapshot.get('effectorSector'),
      effectorAppNb: snapshot.get('effectorAppNb')
    );
  }
  Stream<Effector> get effectorData {
    return effectorCollection.doc(uid).snapshots().map(_effectorFromSnapshot);
  }

  //Création , update d'une commune, on généère nous même l'uid de la base
  Future updateCommuneData(String uidd,String nom,String code,String codeDepartement,String codeRegion,String codePostal,String sasSecteur) async {
    return communeCollection.doc(uidd).set({
      'uid':uidd,
      'nom':nom,
      'code':code,
      'codeDepartement':codeDepartement,
      'codeRegion':codeRegion,
      'codePostal':codePostal,
      'sasSecteur':sasSecteur
    });
  }

  //Création de la liste des communes d'un département à partir de l'api gouv, attention efface la liste précédente
  Future newCommuneList() async {
    await communeCollection.doc().delete();
    var liste = await ApiGouvService().listedesCommunesDeSavoie();
    for (var json in liste){
      
     var v4 = uuid.v4();
      updateCommuneData(v4.toString(),json['nom'], json['code'], json['codeDepartement'], json['codeRegion'], json['codesPostaux'][0],'NP');
    }
  }

  //Création liste de commune à partir du snapshot de la base
  List<Commune> _communeListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Commune(
        uid: doc['uid'],
        nom: doc['nom'],
        code: doc['code'],
        codeDepartement: doc['codeDepartement'],
        codeRegion: doc['codeRegion'],
        codePostal: doc['codePostal'],
        sasSecteur: doc['sasSecteur'],
      );
    }).toList();
  }

  //Stream qui donne accés à la liste des communes
  Stream<List<Commune>> get communes {
    return communeCollection.orderBy('nom').snapshots().map(_communeListFromSnapshot);
  }

  

 
  
}