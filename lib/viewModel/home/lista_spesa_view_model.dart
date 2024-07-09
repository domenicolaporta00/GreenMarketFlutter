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
      ProdottoInListaModel(nome: "Mele2", quantita: 1.5, prezzo: 2.0, prezzoTotale: 3.0),
      ProdottoInListaModel(nome: "Pere2", quantita: 2.0, prezzo: 2.5, prezzoTotale: 5.0),
      ProdottoInListaModel(nome: "Banane2", quantita: 1.0, prezzo: 1.0, prezzoTotale: 1.0),
      ProdottoInListaModel(nome: "Mele3", quantita: 1.5, prezzo: 2.0, prezzoTotale: 3.0),
      ProdottoInListaModel(nome: "Pere3", quantita: 2.0, prezzo: 2.5, prezzoTotale: 5.0),
      ProdottoInListaModel(nome: "Banane3", quantita: 1.0, prezzo: 1.0, prezzoTotale: 1.0),
      ProdottoInListaModel(nome: "Mele4", quantita: 1.5, prezzo: 2.0, prezzoTotale: 3.0),
      ProdottoInListaModel(nome: "Pere4", quantita: 2.0, prezzo: 2.5, prezzoTotale: 5.0),
      ProdottoInListaModel(nome: "Banane4", quantita: 1.0, prezzo: 1.0, prezzoTotale: 1.0),
    ];
    notifyListeners();
  }

  getProdottoByNome(ProdottoInListaModel prod) {
    List<Prodotto> prodotti = [
      Prodotto(nome: "Mele", descrizione: "Sono mele", prezzo: 2.0, foto: "images/mela.jpg"),
      Prodotto(nome: "Pere", descrizione: "Sono pere", prezzo: 2.5, foto: "images/pera.jpg"),
      Prodotto(nome: "Banane", descrizione: "Sono banane", prezzo: 1.0, foto: "images/banana.jpg"),
      Prodotto(nome: "Mele2", descrizione: "Sono mele", prezzo: 2.0, foto: "images/mela.jpg"),
      Prodotto(nome: "Pere2", descrizione: "Sono pere", prezzo: 2.5, foto: "images/pera.jpg"),
      Prodotto(nome: "Banane2", descrizione: "Sono banane", prezzo: 1.0, foto: "images/banana.jpg"),
      Prodotto(nome: "Mele3", descrizione: "Sono mele", prezzo: 2.0, foto: "images/mela.jpg"),
      Prodotto(nome: "Pere3", descrizione: "Sono pere", prezzo: 2.5, foto: "images/pera.jpg"),
      Prodotto(nome: "Banane3", descrizione: "Sono banane", prezzo: 1.0, foto: "images/banana.jpg"),
      Prodotto(nome: "Mele4", descrizione: "Sono mele", prezzo: 2.0, foto: "images/mela.jpg"),
      Prodotto(nome: "Pere4", descrizione: "Sono pere", prezzo: 2.5, foto: "images/pera.jpg"),
      Prodotto(nome: "Banane4", descrizione: "Sono banane", prezzo: 1.0, foto: "images/banana.jpg"),
      Prodotto(nome: "Mele5", descrizione: "Sono mele", prezzo: 2.0, foto: "images/mela.jpg"),
      Prodotto(nome: "Pere5", descrizione: "Sono pere", prezzo: 2.5, foto: "images/pera.jpg"),
      Prodotto(nome: "Banane5", descrizione: "Sono banane", prezzo: 1.0, foto: "images/banana.jpg")
    ];
    _prodottoDettagliato = prodotti.firstWhere((p)=>p.nome == prod.nome);
    notifyListeners();
  }

  deleteListaSpesa() {
    _listaProdotti = [];
    getTotale();
    notifyListeners();
  }

  deleteByName(String nome) {
    List<ProdottoInListaModel> prodotti = [
      ProdottoInListaModel(nome: "Mele", quantita: 1.5, prezzo: 2.0, prezzoTotale: 3.0),
      ProdottoInListaModel(nome: "Pere", quantita: 2.0, prezzo: 2.5, prezzoTotale: 5.0),
      ProdottoInListaModel(nome: "Banane", quantita: 1.0, prezzo: 1.0, prezzoTotale: 1.0),
      ProdottoInListaModel(nome: "Mele2", quantita: 1.5, prezzo: 2.0, prezzoTotale: 3.0),
      ProdottoInListaModel(nome: "Pere2", quantita: 2.0, prezzo: 2.5, prezzoTotale: 5.0),
      ProdottoInListaModel(nome: "Banane2", quantita: 1.0, prezzo: 1.0, prezzoTotale: 1.0),
      ProdottoInListaModel(nome: "Mele3", quantita: 1.5, prezzo: 2.0, prezzoTotale: 3.0),
      ProdottoInListaModel(nome: "Pere3", quantita: 2.0, prezzo: 2.5, prezzoTotale: 5.0),
      ProdottoInListaModel(nome: "Banane3", quantita: 1.0, prezzo: 1.0, prezzoTotale: 1.0),
      ProdottoInListaModel(nome: "Mele4", quantita: 1.5, prezzo: 2.0, prezzoTotale: 3.0),
      ProdottoInListaModel(nome: "Pere4", quantita: 2.0, prezzo: 2.5, prezzoTotale: 5.0),
      ProdottoInListaModel(nome: "Banane4", quantita: 1.0, prezzo: 1.0, prezzoTotale: 1.0),
    ];
    prodotti.removeWhere((p)=>p.nome == nome);
    _listaProdotti = prodotti;
    getTotale();
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

  showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}