//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//Module de connexion aux services d'état
//SAS MANAGER v0.1.5

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ApiGouvService{

  Future  listedesCommunesDeSavoie() async {

    var url = 'https://geo.api.gouv.fr/departements/73/communes';

    var response = await http.get(url);

    if(response.statusCode == 200){
      print("Appel Api gouv correct");
      var jsonresponse = convert.jsonDecode(response.body);
      return jsonresponse;
    }else{
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }
}