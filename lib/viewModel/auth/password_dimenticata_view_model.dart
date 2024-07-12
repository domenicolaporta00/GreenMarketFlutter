import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/auth.dart';

class PasswordDimenticataViewModel{

  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  final Auth auth = Auth();
  
  Future<bool> recuperaPassword(String email, BuildContext context) async {
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
        try {
          await auth.sendPasswordResetEmail(email);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email per il recupero password inviata')),
          );
          return true;
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${e.toString()}')),
          );
          return false;
        }

      }
    }
  }

  showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  
}