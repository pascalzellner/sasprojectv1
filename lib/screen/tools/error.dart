import 'package:flutter/material.dart';

class Error extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Erreur Connexion')),
      body: Text('Base de donnée inacessible'),
    );
  }
}