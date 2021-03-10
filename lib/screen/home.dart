import 'package:flutter/material.dart';

import 'package:sasprojectv1/models/effector.dart';
import 'package:provider/provider.dart';
import 'package:sasprojectv1/screen/Home/homeadmin.dart';
import 'package:sasprojectv1/screen/Home/homeeffec.dart';
import 'package:sasprojectv1/screen/Home/homemnspeffec.dart';
import 'package:sasprojectv1/screen/tools/loading.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

   
    
    final Effector actualUser = Provider.of<Effector>(context);

    if (actualUser==null){
      return Loading();
    }else{

      switch(actualUser.effectorRole){
      case'ADM':
      return HomeAdm(actualuser: actualUser,);
      break;
      case'MSNP':
      break;
      case'MRH':
      break;
      case'MSNP-EFFEC':
      return HomeMNSPeffec(actualuser: actualUser,);
      break;
      case'MEFFEC':
      return HomeEFFEC(actualuser: actualUser,);
      break;
      case'ARM':
      break;
      case'SEC':
      break;
      case'OSNP':
      break;
      default:
      return HomeAdm(actualuser: actualUser,);
      }
    }
  }
}