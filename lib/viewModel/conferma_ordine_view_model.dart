import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/user_model.dart';
import '../services/database_service.dart';

class ConfermaOrdineViewModel extends ChangeNotifier {
  User? currentUser = FirebaseAuth.instance.currentUser;

  String _indirizzo = "";
  String get indirizzo => _indirizzo;

  //Metodo che torna l'indirizzo associato all'utente loggato
  Future<void> getIndirizzo() async {
    final currentUser = this.currentUser;
    if (currentUser != null) {
      DatabaseService databaseService = DatabaseService(uid: currentUser.uid);
      UserModel? userData = await databaseService.getUser();
      _indirizzo = userData!.indirizzo;
      notifyListeners();
    }

  }

  showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}