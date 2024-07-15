import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';
import '../../services/auth.dart';
import '../../services/database_service.dart';

class RegistrazioneViewModel {

  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

  //Metodo che gestisce la registrazione
  Future<bool> effettuaRegistrazione(String nome, String cognome, String indirizzo,
      String email,  String password, String confirmPassword, Map<String, List<double>> listaDellaSpesa, BuildContext context) async {

    if(nome.isEmpty || cognome.isEmpty || indirizzo.isEmpty ||
        email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      showSnackBar("Completare tutti i campi!", context);
      return false;
    }
    else if(limitaCaratteri(nome, cognome, indirizzo, email, password, confirmPassword)){
      showSnackBar("I campi possono contere max 50 caratteri", context);
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
              UserModel newUser = UserModel(nome: nome, cognome: cognome, indirizzo: indirizzo, listaDellaSpesa: listaDellaSpesa);
              await databaseService.createUser(newUser);
            }
            showSnackBar("Registrazione avvenuta con successo", context);
            return true;
          }on FirebaseAuthException catch(error){
            switch (error.code) {
              case 'email-already-in-use':
                showSnackBar("L'email è già associata ad un altro account", context);
                break;
              case 'invalid-email':
                showSnackBar("Email non formattata correttamente", context);
                break;
              case 'operation-not-allowed':
                showSnackBar('Email/password non sono associati ad alcun account', context);
                break;
              case 'weak-password':
                showSnackBar('Password debole', context);
                break;
              default:
                showSnackBar("Errore indefinito: ${error.message}", context);
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

  //Metodo per limitare i caratteri inseriti dall'utente
  bool limitaCaratteri(String nome, String cognome, String indirizzo,
      String email,  String password, String confirmPassword) {
    if (nome.length > 50 || cognome.length > 50 || indirizzo.length > 50 || email.length > 50 || password.length > 50
        || confirmPassword.length > 50) {
      return true;
    } else {
      return false;
    }
  }

}