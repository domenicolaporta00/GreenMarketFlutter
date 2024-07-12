import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_market_flutter/model/product_model.dart';

import '../../services/database_service.dart';

class RicercaViewModel extends ChangeNotifier {


  List<ProductModel>? _listaProdotti = [];
  List<ProductModel>? get listaProdotti => _listaProdotti;

  ProductModel _prodottoDettagliato = ProductModel(nome: "", descrizione: "", prezzo: 0.0, foto: "");
  ProductModel get prodottoDettagliato => _prodottoDettagliato;

  Future<List<ProductModel>> getProdotti() async {
    try {
      // Recupera la raccolta 'product' da Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('product').get();

      // Converte ogni documento in un oggetto ProdottoModel
      List<ProductModel> prodotti = querySnapshot.docs.map((doc) {
        // Usa il metodo fromFirestore per convertire la mappa in un oggetto ProdottoModel
        return ProductModel.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();

      return prodotti;
    } catch (e) {
      print("Errore nel recuperare i prodotti: $e");
      return [];
    }
  }

  getProdottoByNome(String nome, BuildContext context) {
    List<ProductModel> prodotti = [
      ProductModel(nome: "Mele", descrizione: "Sono mele", prezzo: 2.0, foto: "images/mela.jpg"),
      ProductModel(nome: "Pere", descrizione: "Sono pere", prezzo: 2.5, foto: "images/pera.jpg"),
      ProductModel(nome: "Banane", descrizione: "Sono banane", prezzo: 1.0, foto: "images/banana.jpg"),
      ProductModel(nome: "Mele2", descrizione: "Sono mele", prezzo: 2.0, foto: "images/mela.jpg"),
      ProductModel(nome: "Pere2", descrizione: "Sono pere", prezzo: 2.5, foto: "images/pera.jpg"),
      ProductModel(nome: "Banane2", descrizione: "Sono banane", prezzo: 1.0, foto: "images/banana.jpg"),
      ProductModel(nome: "Mele3", descrizione: "Sono mele", prezzo: 2.0, foto: "images/mela.jpg"),
      ProductModel(nome: "Pere3", descrizione: "Sono pere", prezzo: 2.5, foto: "images/pera.jpg"),
      ProductModel(nome: "Banane3", descrizione: "Sono banane", prezzo: 1.0, foto: "images/banana.jpg"),
      ProductModel(nome: "Mele4", descrizione: "Sono mele", prezzo: 2.0, foto: "images/mela.jpg"),
      ProductModel(nome: "Pere4", descrizione: "Sono pere", prezzo: 2.5, foto: "images/pera.jpg"),
      ProductModel(nome: "Banane4", descrizione: "Sono banane", prezzo: 1.0, foto: "images/banana.jpg"),
      ProductModel(nome: "Mele5", descrizione: "Sono mele", prezzo: 2.0, foto: "images/mela.jpg"),
      ProductModel(nome: "Pere5", descrizione: "Sono pere", prezzo: 2.5, foto: "images/pera.jpg"),
      ProductModel(nome: "Banane5", descrizione: "Sono banane", prezzo: 1.0, foto: "images/banana.jpg")
    ];
    nome = nome[0].toUpperCase() + nome.substring(1).toLowerCase();
    ProductModel placeholder = ProductModel(nome: "", descrizione: "", prezzo: 0.0, foto: "");
    var prodotto = prodotti.firstWhere(
          (p) => p.nome == nome, orElse: () => placeholder,
    );
    if (prodotto != placeholder) {
      _listaProdotti = [prodotto];
    } else {
      showSnackBar("Non ci sono prodotti con questo nome", context);
      getProdotti();
    }
    notifyListeners();
  }

  readProdottoDettagliato(String nome) {
    List<ProductModel> prodotti = [
      ProductModel(nome: "Mele", descrizione: "Sono mele", prezzo: 2.0, foto: "images/mela.jpg"),
      ProductModel(nome: "Pere", descrizione: "Sono pere", prezzo: 2.5, foto: "images/pera.jpg"),
      ProductModel(nome: "Banane", descrizione: "Sono banane", prezzo: 1.0, foto: "images/banana.jpg"),
      ProductModel(nome: "Mele2", descrizione: "Sono mele", prezzo: 2.0, foto: "images/mela.jpg"),
      ProductModel(nome: "Pere2", descrizione: "Sono pere", prezzo: 2.5, foto: "images/pera.jpg"),
      ProductModel(nome: "Banane2", descrizione: "Sono banane", prezzo: 1.0, foto: "images/banana.jpg"),
      ProductModel(nome: "Mele3", descrizione: "Sono mele", prezzo: 2.0, foto: "images/mela.jpg"),
      ProductModel(nome: "Pere3", descrizione: "Sono pere", prezzo: 2.5, foto: "images/pera.jpg"),
      ProductModel(nome: "Banane3", descrizione: "Sono banane", prezzo: 1.0, foto: "images/banana.jpg"),
      ProductModel(nome: "Mele4", descrizione: "Sono mele", prezzo: 2.0, foto: "images/mela.jpg"),
      ProductModel(nome: "Pere4", descrizione: "Sono pere", prezzo: 2.5, foto: "images/pera.jpg"),
      ProductModel(nome: "Banane4", descrizione: "Sono banane", prezzo: 1.0, foto: "images/banana.jpg"),
      ProductModel(nome: "Mele5", descrizione: "Sono mele", prezzo: 2.0, foto: "images/mela.jpg"),
      ProductModel(nome: "Pere5", descrizione: "Sono pere", prezzo: 2.5, foto: "images/pera.jpg"),
      ProductModel(nome: "Banane5", descrizione: "Sono banane", prezzo: 1.0, foto: "images/banana.jpg")
    ];
    _prodottoDettagliato = prodotti.firstWhere((p)=>p.nome == nome);
    notifyListeners();
  }


  showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}