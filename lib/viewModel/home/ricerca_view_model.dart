import 'dart:core';
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_market_flutter/model/product_model.dart';

import '../../services/database_service.dart';

class RicercaViewModel extends ChangeNotifier {


  final List<ProductModel> _listaProdotti = [];
  List<ProductModel>? get listaProdotti => _listaProdotti;

  final ProductModel _prodottoDettagliato = ProductModel(nome: "", descrizione: "", prezzo: 0.0, foto: "");
  ProductModel get prodottoDettagliato => _prodottoDettagliato;

  Future<List<ProductModel>> getProdotti() async {
    try {
      // Recupera la raccolta 'product' da Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('products').get();

      // Converte ogni documento in un oggetto ProdottoModel
      List<ProductModel> prodotti = querySnapshot.docs.map((doc) {
        // Usa il metodo fromFirestore per convertire la mappa in un oggetto ProdottoModel
        return ProductModel.fromDocument(doc);
      }).toList();

      return prodotti;
    } catch (e) {
      print("Errore nel recuperare i prodotti: $e");
      return [];
    }
  }

  Future<List<ProductModel>> getProdottoByNome({required String nome}) async {
    nome = stringaFormattata(nome);
    if (nome.isNotEmpty) {
      try {
        final productDoc = await FirebaseFirestore.instance
            .collection('products')
            .doc(nome)
            .get();

        if (productDoc.exists) {
          ProductModel product = ProductModel.fromDocument(productDoc);
          return [product];
        } else {
          print("Prodotto non trovato");
          return [];
        }
      } catch (e) {
        print("Errore nella ricerca del prodotto: $e");
        return [];
      }
    } else {
      print("Inserisci il nome di un prodotto");
      return [];
    }
  }

  stringaFormattata(String nome){
    if (nome.isEmpty) {
      return '';
    }else{
      return '${nome[0].toUpperCase()}${nome.substring(1).toLowerCase()}';
    }
  }

  showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}