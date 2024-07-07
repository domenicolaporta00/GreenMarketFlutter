import 'package:flutter/material.dart';
import 'package:green_market_flutter/model/prodotto.dart';

class RicercaViewModel extends ChangeNotifier {

  List<Prodotto> _listaProdotti = [];
  List<Prodotto> get listaProdotti => _listaProdotti;

  Prodotto _prodottoDettagliato = Prodotto(nome: "", descrizione: "", prezzo: 0.0, foto: "");
  Prodotto get prodottoDettagliato => _prodottoDettagliato;

  getListaProdotti() {
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
    _listaProdotti = prodotti;
    notifyListeners();
  }

  getProdottoByNome(String nome, BuildContext context) {
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
    nome = nome[0].toUpperCase() + nome.substring(1).toLowerCase();
    Prodotto placeholder = Prodotto(nome: "", descrizione: "", prezzo: 0.0, foto: "");
    var prodotto = prodotti.firstWhere(
          (p) => p.nome == nome, orElse: () => placeholder,
    );
    if (prodotto != placeholder) {
      _listaProdotti = [prodotto];
    } else {
      showSnackBar("Non ci sono prodotti con questo nome", context);
      getListaProdotti();
    }
    notifyListeners();
  }

  readProdottoDettagliato(String nome) {
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
    _prodottoDettagliato = prodotti.firstWhere((p)=>p.nome == nome);
    notifyListeners();
  }

  showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}