//@author : Pascal ZELLNER
//@CopyRight : Pascal ZELLNER - SAMU 73 - 2021
//@licence : MIT
//Service de gestion de l'identification et de l'attribution des tokens
//SAS MANAGER v0.1.5

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sasprojectv1/models/sasuser.dart';
import 'package:sasprojectv1/services/database.dart';

class AuthService {

final FirebaseAuth _auth = FirebaseAuth.instance;

SasUser _sasuserFromFirebaseUser (User user){
  return user != null? SasUser(uid : user.uid) : null;
}

//Stream qui écoute les changements d'identification
Stream<SasUser> get user {
  return _auth.authStateChanges()
    .map(_sasuserFromFirebaseUser);
}

//sign in anon
Future signInAnon() async {
  try {

    UserCredential userCredential = await _auth.signInAnonymously();
    User user = userCredential.user;
    return _sasuserFromFirebaseUser(user);

  }catch(e){

    return null;

  }
}

//sign out
Future signOut() async {

  try {
    return await _auth.signOut();
  } catch(e) {
    
    return null;
  }
}

//register with email and password
Future registerWithEmailAndPassword(String email, String password) async {

try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    User user = userCredential.user;
    //création des détails du user dans la base
   
    await DataBaseService(uid:user.uid).updateEffectorData('NP', 'NP', 'NP', 'NP', 'NP', 'NP', 'Chambéry', 'NP', 'NP', 'NP', 'NP',0);
    return _sasuserFromFirebaseUser(user);

} catch(e) {
  
  return null;
}

}

//sign in avec email et password
Future signInWithEmailAndPassword(String email, String password) async {

try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    User user = userCredential.user;
    
    return _sasuserFromFirebaseUser(user);

} catch(e) {
  
  return null;
}

}
}