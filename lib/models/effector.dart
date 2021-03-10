//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//Modèle de gestion des effecteurs

class Effector {

  final String sasSectorName;
  final String sasSectorId;
  final String effectorId;
  final String effectorRole;
  final String effectorName;
  final String effectorCommune;
  final String effectorCP;
  final String effectorAddress;
  final String effectorRPPS;
  final String effectorSpe;
  final String effectorSector;
  final int effectorAppNb;

  Effector({this.sasSectorName,this.sasSectorId,this.effectorId,this.effectorRole,this.effectorName,this.effectorCommune,
  this.effectorCP,this.effectorAddress,this.effectorRPPS,this.effectorSpe,this.effectorSector,this.effectorAppNb});
}