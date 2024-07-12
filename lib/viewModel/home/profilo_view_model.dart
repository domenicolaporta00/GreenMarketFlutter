import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_market_flutter/View/authScreens/login.dart';
import 'package:green_market_flutter/services/auth.dart';

import '../../model/user_model.dart';
import '../../services/database_service.dart';

class ProfiloViewModel extends ChangeNotifier {

  String _nome = "";

  String get nome => _nome;

  String _cognome = "";

  String get cognome => _cognome;

  String _indirizzo = "";

  String get indirizzo => _indirizzo;

  UserModel? _user;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  void loadUserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DatabaseService databaseService = DatabaseService(uid: currentUser.uid);
      UserModel? userData = await databaseService.getUser();
      _nome = userData!.nome;
      _cognome = userData.cognome;
      _indirizzo = userData.indirizzo;
      notifyListeners();
    }
  }

  void updateUser(String nome, String cognome, String indirizzo,
      BuildContext context) async {
    if (nome == _user?.nome && cognome == _user?.cognome &&
        indirizzo == _user?.indirizzo) {
      showSnackBar("Nessun dato aggiornato", context);
    }
    if (nome.isEmpty || cognome.isEmpty || indirizzo.isEmpty) {
      showSnackBar("Completare tutti i campi", context);
    }
    else {
      UserModel updatedUser = UserModel(
        nome: nome,
        cognome: cognome,
        indirizzo: indirizzo,
      );
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        DatabaseService databaseService = DatabaseService(uid: currentUser.uid);
        await databaseService.updateUser(updatedUser);
      }
      loadUserData();
      _user = updatedUser;
      showSnackBar("$_nome Dati aggiornati con successo", context);
      notifyListeners();
    }
  }

  //Funzione che richiama le funzioni utili all'eliminazione dell'utente
  void deleteUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DatabaseService databaseService = DatabaseService(uid: currentUser.uid);
      Auth auth = Auth();

      await databaseService.deleteUser();
      await auth.deleteUser();
    }
  }




  /*
  setDati(String nome, String cognome, String indirizzo, BuildContext context) {
    if(nome == _nome && cognome == _cognome && indirizzo == _indirizzo) {
      showSnackBar("Nessun dato aggiornato", context);
    }
    if(nome.isEmpty || cognome.isEmpty || indirizzo.isEmpty) {
      showSnackBar("Completare tutti i campi", context);
    }
    else {
      _nome = nome;
      _cognome = cognome;
      _indirizzo = indirizzo;
      showSnackBar("$_nome Dati aggiornati con successo", context);
      notifyListeners();
    }
  }
  */

  logout(BuildContext context) {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Conferma Logout'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Sei sicuro di voler uscire?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(); // Chiudi il dialogo
                },
              ),
              TextButton(
                child: const Text('SÌ'),
                onPressed: () {
                  Navigator.of(context).pop(); // Chiudi il dialogo
                  Navigator.pop(context);
                  signOut();
                  showSnackBar("Logout effettuato con successo",
                      context); // Esegui il logout
                },
              ),
            ],
          );
        }
    );
  }

  deleteAccount(BuildContext context) {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Conferma Eliminazione Account'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Sei sicuro di voler eliminare l'account?"),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(); // Chiudi il dialogo
                },
              ),
              TextButton(
                child: const Text('SÌ'),
                onPressed: () {
                  deleteUser();
                  Navigator.of(context).pop(); // Chiudi il dialogo
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => const MyLoginActivity()),
                  );
                  showSnackBar("Account eliminato con successo",
                      context); // Esegui il logout
                },
              ),
            ],
          );
        }
    );
  }

  showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}