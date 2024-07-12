import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';
import '../../services/auth.dart';
import '../../services/database_service.dart';

class RegistrazioneViewModel {

  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

  Future<bool> effettuaRegistrazione(String nome, String cognome, String indirizzo,
      String email, String password, String confirmPassword, BuildContext context) async {

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
          try{
            Auth auth = Auth();
            User? user = await auth.registerWithEmailAndPassword(email, password);
            if (user != null) {
              DatabaseService databaseService = DatabaseService(uid: user.uid);
              UserModel newUser = UserModel(nome: nome, cognome: cognome, indirizzo: indirizzo);
              await databaseService.createUser(newUser);
            }
            showSnackBar("Registrazione avvenuta con successo", context);
            return true;
          }on FirebaseAuthException catch(error){
            switch (error.code) {
              case 'email-already-in-use':
                showSnackBar('The email address is already in use by another account.', context);
                // Handle email already in use
                break;
              case 'invalid-email':
                showSnackBar('The email address is badly formatted.', context);
                // Handle invalid email
                break;
              case 'operation-not-allowed':
                showSnackBar('Email/password accounts are not enabled.', context);
                // Handle operation not allowed
                break;
              case 'weak-password':
                showSnackBar('The password is too weak.', context);
                // Handle weak password
                break;
              default:
                showSnackBar('An undefined Error happened: ${error.message}', context);
            // Handle other errors
            }
            return false;
          }

        }
      }
    }
  }

  showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}