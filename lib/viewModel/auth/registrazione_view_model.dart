import 'package:flutter/material.dart';

class RegistrazioneViewModel {

  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

  effettuaRegistrazione(String nome, String cognome, String indirizzo,
      String email, String password, String confirmPassword, BuildContext context) {
    if(nome.isEmpty || cognome.isEmpty || indirizzo.isEmpty ||
        email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      showSnackBar("Completare tutti i campi!", context);
      return false;
    }
    else {
      if(!emailRegex.hasMatch(email)) {
        showSnackBar("Formato email non corretto", context);
        return false;
      }
      else {
        if(password != confirmPassword) {
          showSnackBar("Conferma password errata!", context);
          return false;
        }
        else {
          //registrazione
          showSnackBar("Registrazione avvenuta con successo", context);
          return true;
        }
      }
    }
  }

  showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}