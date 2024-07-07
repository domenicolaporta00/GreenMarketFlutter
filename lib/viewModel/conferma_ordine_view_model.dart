import 'package:flutter/material.dart';

class ConfermaOrdineViewModel extends ChangeNotifier {

  String _indirizzo = "";
  String get indirizzo => _indirizzo;

  getIndirizzo() {
    _indirizzo = "Via Marziale 2";
    notifyListeners();
  }

  showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}