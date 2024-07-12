import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_market_flutter/services/auth.dart';

class LoginViewModel {

  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

  Future<bool> effettuaLogin(String email, String password, BuildContext context) async {

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

        try{
          if(await Auth().signInWithEmailAndPassword(email, password) == null){
            showSnackBar("Impossibile accedere", context);
            return false;
          }else{
            showSnackBar("Accesso effettuato con successo", context);
            return true;
          }
        }on FirebaseAuthException catch(error){
          switch (error.code) {
            case 'invalid-email':
              showSnackBar('The email address is badly formatted.', context);
              // Handle invalid email
              break;
            case 'user-disabled':
              showSnackBar('The user account has been disabled.', context);
              // Handle user disabled
              break;
            case 'user-not-found':
              showSnackBar('No user found for that email.', context);
              // Handle user not found
              break;
            case 'wrong-password':
              showSnackBar('Wrong password provided.', context);
              // Handle wrong password
              break;
            default:
              showSnackBar('An undefined Error happened.', context);
          // Handle other errors
          }
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