import 'package:green_market_flutter/model/prodotto.dart';
import 'package:green_market_flutter/model/prodotto_in_lista_model.dart';
import 'package:flutter/material.dart';

class ListaSpesaViewModel extends ChangeNotifier {

  /*ListaSpesaModel _listaSpesa = ListaSpesaModel(prodotti: {});
  ListaSpesaModel get listaSpesa => _listaSpesa;*/

  List<ProdottoInListaModel> _listaProdotti = [];
  List<ProdottoInListaModel> get listaProdotti => _listaProdotti;

  Prodotto _prodottoDettagliato = Prodotto(nome: "", descrizione: "", prezzo: 0.0, foto: "");
  Prodotto get prodottoDettagliato => _prodottoDettagliato;

  double _totale = 0.0;
  double get totale => _totale;

  getListaSpesa() {
    /*_listaSpesa = ListaSpesaModel(prodotti: {
      "Mele": [1.5, 2.0, 3.0],
      "Pere": [2.0, 2.5, 5.0],
      "Banane": [1.0, 1.0, 1.0]
    });*/
    _listaProdotti = [
      ProdottoInListaModel(nome: "Mele", quantita: 1.5, prezzo: 2.0, prezzoTotale: 3.0),
      ProdottoInListaModel(nome: "Pere", quantita: 2.0, prezzo: 2.5, prezzoTotale: 5.0),
      ProdottoInListaModel(nome: "Banane", quantita: 1.0, prezzo: 1.0, prezzoTotale: 1.0),
    ];
    notifyListeners();
  }

  getProdottoByNome(String nome) {
    List<Prodotto> prodotti = [
      Prodotto(nome: "Mele", descrizione: "Sono mele", prezzo: 2.0, foto: ""),
      Prodotto(nome: "Pere", descrizione: "Sono pere", prezzo: 2.5, foto: ""),
      Prodotto(nome: "Banane", descrizione: "Sono banane", prezzo: 1.0, foto: "")
    ];
    _prodottoDettagliato = prodotti.firstWhere((p)=>p.nome == nome);
    notifyListeners();
  }

  deleteListaSpesa() {
    _listaProdotti = [];
    notifyListeners();
  }

  deleteByName(String nome) {
    List<ProdottoInListaModel> prodotti = [
      ProdottoInListaModel(nome: "Mele", quantita: 1.5, prezzo: 2.0, prezzoTotale: 3.0),
      ProdottoInListaModel(nome: "Pere", quantita: 2.0, prezzo: 2.5, prezzoTotale: 5.0),
      ProdottoInListaModel(nome: "Banane", quantita: 1.0, prezzo: 1.0, prezzoTotale: 1.0),
    ];
    prodotti.removeWhere((p)=>p.nome == nome);
    _listaProdotti = prodotti;
    notifyListeners();
  }

  getTotale() {
    double tot = 0.0;
    for(var i in _listaProdotti) {
      tot = tot + i.prezzoTotale;
    }
    _totale = tot;
    notifyListeners();
  }

}