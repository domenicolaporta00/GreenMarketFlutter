import 'package:flutter/material.dart';
import 'package:green_market_flutter/View/authScreens/login.dart';

class ProfiloViewModel extends ChangeNotifier {

  String _nome = "";
  String get nome => _nome;

  String _cognome = "";
  String get cognome => _cognome;

  String _indirizzo = "";
  String get indirizzo => _indirizzo;

  getDati() {
    _nome = "Domenico";
    _cognome = "La Porta";
    _indirizzo = "Via Marziale 2";
    notifyListeners();
  }

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
                showSnackBar("Logout effettuato con successo", context); // Esegui il logout
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
                  Navigator.of(context).pop(); // Chiudi il dialogo
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const MyLoginActivity()),
                  );
                  showSnackBar("Account eliminato con successo", context); // Esegui il logout
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