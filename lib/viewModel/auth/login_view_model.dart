import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_market_flutter/services/auth.dart';

class LoginViewModel {

  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

  //Metodo che gestisce il login mediante email e password
  Future<bool> effettuaLogin(String email, String password, BuildContext context) async {

    if(email.isEmpty || password.isEmpty) {
      showSnackBar("Completare tutti i campi!", context);
      return false;
    }
    else if(limitaCaratteri(email, password)){
      showSnackBar("I campi possono contere max 50 caratteri", context);
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
            showSnackBar("Impossibile accedere: Credenziali errate", context);
            return false;
          }else{
            return true;
          }
        }on FirebaseAuthException catch(error){
          switch (error.code) {
            case 'invalid-email':
              showSnackBar("L'email non è ben formattata", context);
              // Handle invalid email
              break;
            case 'user-disabled':
              showSnackBar("L'account utente è disabilitato", context);
              // Handle user disabled
              break;
            case 'user-not-found':
              showSnackBar("Nessun utente corrisponde a questa email", context);
              // Handle user not found
              break;
            case 'wrong-password':
              showSnackBar('Password errata.', context);
              // Handle wrong password
              break;
            default:
              showSnackBar('Errore inatteso', context);
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

  //Metodo per limitare i caratteri inseriti dall'utente
  bool limitaCaratteri(String email, String password) {
    if (email.length > 50 || password.length > 50) {
      return true;
    } else {
      return false;
    }
  }

}