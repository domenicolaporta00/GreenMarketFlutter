import 'package:flutter/material.dart';
import 'package:green_market_flutter/model/prodotto.dart';
import 'package:green_market_flutter/model/prodotto_in_lista_model.dart';

class DettaglioProdottoViewModel extends ChangeNotifier{

  double _quantita = 0.5;
  double get quantita => _quantita;

  List<ProdottoInListaModel> lista = [];

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

  addProdottoInLista(Prodotto prodotto, BuildContext context) {
    ProdottoInListaModel prodInLista = ProdottoInListaModel(
        nome: prodotto.nome,
        quantita: _quantita,
        prezzo: prodotto.prezzo,
        prezzoTotale: _quantita*prodotto.prezzo
    );
    if(contains(prodInLista)) {
      lista.removeWhere((p) => p.nome == prodInLista.nome);
    }
    lista.add(prodInLista);
    for(var i in lista) {
      showSnackBar("${i.nome} ${i.prezzo} ${i.quantita} ${i.prezzoTotale}", context);
    }
  }

  bool contains(ProdottoInListaModel prodotto) {
    for(var i in lista) {
      if(prodotto.nome == i.nome) {
        return true;
      }
    }
    return false;
  }

  showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}