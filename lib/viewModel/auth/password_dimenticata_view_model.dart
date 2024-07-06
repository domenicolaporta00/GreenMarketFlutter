import 'package:flutter/material.dart';

class PasswordDimenticataViewModel{

  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  
  recuperaPassword(String email, BuildContext context) {
    if(email.isEmpty) {
      showSnackBar("Inserire un'email!", context);
      return false;
    }
    else {
      if(!emailRegex.hasMatch(email)) {
        showSnackBar("Formato email non corretto", context);
        return false;
      }
      else {
        //recupero password
        showSnackBar("Email inviata", context);
        return true;
      }
    }
  }

  showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  
}