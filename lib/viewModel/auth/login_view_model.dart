import 'package:flutter/material.dart';

class LoginViewModel {

  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

  effettuaLogin(String email, String password, BuildContext context) {
    if(email.isEmpty || password.isEmpty) {
      showSnackBar("Completare tutti i campi!", context);
      return false;
    }
    else {
      if(!emailRegex.hasMatch(email)) {
        showSnackBar("Formato email non corretto", context);
        return false;
      }
      else {
        //login
        showSnackBar("Accesso effettuato con successo", context);
        return true;
      }
    }
  }

  showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}