import 'package:flutter/material.dart';

class DettaglioProdottoViewModel extends ChangeNotifier{

  double _quantita = 0.5;
  double get quantita => _quantita;

  setQuantita(double quantita) {
    _quantita = quantita;
    notifyListeners();
  }

  incrementaQuantita(BuildContext context) {
    if(_quantita<100) {
      _quantita = _quantita + 0.5;
    }
    else {
      showSnackBar("La quantità non può superare 100.0 kg", context);
    }
    notifyListeners();
  }

  decrementaQuantita(BuildContext context) {
    if(_quantita>0.5) {
      _quantita = _quantita - 0.5;
    }
    else {
      showSnackBar("La quantità non può essere negativa/nulla", context);
    }
    notifyListeners();
  }

  showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}