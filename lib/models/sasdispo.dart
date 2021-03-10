//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//Modèle de gestion des disponibilités

class Sasdispo{
  
 final String sasdispoId;
 final String sasdispoSecteur;
 final DateTime sasdispoDeb;
 final DateTime sasdispoEnd;
 final String sasdispoEffectorName;
 final String sasdispoEffectorId;
 final String sasdispoEffectorSpe;
 final String sasdispoType;
 final String sasdispoPatientMail;
 final bool sasdispoReal;
 final String sasdispoPatientMt;
 final String sasdispoTxt;
 final String sasdispoAffaire;

 Sasdispo({this.sasdispoId,this.sasdispoSecteur,this.sasdispoDeb,this.sasdispoEnd,this.sasdispoEffectorName,this.sasdispoEffectorId,
 this.sasdispoEffectorSpe,this.sasdispoType,this.sasdispoPatientMail,this.sasdispoReal,this.sasdispoPatientMt,this.sasdispoTxt,this.sasdispoAffaire});

}