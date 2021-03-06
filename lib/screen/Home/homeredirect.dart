//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//SAS MANAGER v1.0.2

import 'package:flutter/material.dart';

import 'package:sasprojectv1/models/effector.dart';
import 'package:sasprojectv1/screen/Home/homeadmin.dart';
import 'package:sasprojectv1/screen/Home/homearm.dart';
import 'package:sasprojectv1/screen/Home/homeeffec.dart';
import 'package:sasprojectv1/screen/Home/homemnspeffec.dart';
import 'package:sasprojectv1/screen/Home/homemrh.dart';
import 'package:sasprojectv1/screen/Home/homemsnp.dart';
import 'package:sasprojectv1/screen/Home/homeosnp.dart';
import 'package:sasprojectv1/screen/Home/homesec.dart';
import 'package:sasprojectv1/screen/tools/loading.dart';
import 'package:sasprojectv1/screen/Home/homeNP.dart';

class HomeRedirect extends StatelessWidget {

  final Effector actualUser;
  HomeRedirect({this.actualUser});

  @override
  Widget build(BuildContext context) {

    if (actualUser==null){
      return Loading();
    }else{

      switch(actualUser.effectorRole){
      case'ADM':
      return HomeAdm(actualuser: actualUser,);
      break;
      case'MSNP':
      return HomeMSNP(actualuser: actualUser,);
      break;
      case'MRH':
      return HomeMRH(actualuser: actualUser,);
      break;
      case'MSNP-EFFEC':
      return HomeMNSPeffec(actualuser: actualUser,);
      break;
      case'MEFFEC':
      return HomeEFFEC(actualuser: actualUser,);
      break;
      case'ARM':
      return HomeARM(actualuser: actualUser,);
      break;
      case'SEC':
      return HomeSEC(actualuser: actualUser,);
      break;
      case'OSNP':
      return HomeOSNP(actualuser: actualUser,);
      break;
      default:
      return HomeNP(actualUser: actualUser,);
      }
    }
  }
}