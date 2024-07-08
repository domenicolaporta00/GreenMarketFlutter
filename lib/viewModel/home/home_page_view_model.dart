import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../model/prodotto.dart';

class HomePageViewModel extends ChangeNotifier {

  String _nome = "";
  String get nome => _nome;

  String _status = "";
  String get status => _status;

  String _orari = "";
  String get orari => _orari;

  Color _colore = Colors.red;
  Color get colore => _colore;

  List<Prodotto> _listaProdotti = [];
  List<Prodotto> get listaProdotti => _listaProdotti;

  getNome() {
    String name = "Domenico";
    _nome = name;
    notifyListeners();
  }

  setNome(String nome) {
    _nome = nome;
    notifyListeners();
  }

  getProdottiRandom() {
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
    List<Prodotto> prodRand = [];
    Random rand = Random();
    while(prodRand.length < 3) {
      int randomIndex = rand.nextInt(prodotti.length);
      if(!prodRand.contains(prodotti[randomIndex])) {
        prodRand.add(prodotti[randomIndex]);
      }
    }
    _listaProdotti = prodRand;
    notifyListeners();
  }

  updateStatus() {
    DateTime now = DateTime.now();

    TimeOfDay open = const TimeOfDay(hour: 8, minute: 30);
    TimeOfDay close = const TimeOfDay(hour: 20, minute: 30);

    if(isBetween(now, open, close)) {
      _status = "Aperto";
      _orari = "Chiude alle ${close.hour}:${close.minute}";
      _colore = Colors.green;
    }
    else {
      _status = "Chiuso";
      _orari = "Apre alle ${open.hour}:${open.minute}";
      _colore = Colors.red;
    }
  }

  bool isBetween(DateTime dateTime, TimeOfDay startTime, TimeOfDay endTime) {
    final nowTime = TimeOfDay.fromDateTime(dateTime);

    if((nowTime.hour > startTime.hour) && (nowTime.hour < endTime.hour)) {
      return true;
    }
    if((nowTime.hour == startTime.hour) && (nowTime.minute >= startTime.minute)) {
      return true;
    }
    if((nowTime.hour == endTime.hour) && (nowTime.minute < endTime.minute)) {
      return true;
    }
    else {
      return false;
    }
  }
}