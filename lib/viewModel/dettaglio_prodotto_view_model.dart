import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_market_flutter/model/product_model.dart';
import 'package:green_market_flutter/model/product_in_shopping_list_model.dart';

import '../model/user_model.dart';
import '../services/database_service.dart';

class DettaglioProdottoViewModel extends ChangeNotifier {
  User? currentUser = FirebaseAuth.instance.currentUser;

  double _quantita = 0.5;

  double get quantita => _quantita;

  List<ProductInShoppingList> lista = [];

  setQuantita(double quantita) {
    _quantita = quantita;
    notifyListeners();
  }

  incrementaQuantita(BuildContext context) {
    if (_quantita < 100) {
      _quantita = _quantita + 0.5;
    }
    else {
      showSnackBar("La quantità non può superare 100.0 kg", context);
    }
    notifyListeners();
  }

  decrementaQuantita(BuildContext context) {
    if (_quantita > 0.5) {
      _quantita = _quantita - 0.5;
    }
    else {
      showSnackBar("La quantità non può essere negativa/nulla", context);
    }
    notifyListeners();
  }

  //Metodo che gestisce l'inserimento di un prodotto nella lista della spesa
  Future<void> addProductToShoppingList(ProductModel prodotto, BuildContext context) async {
    final DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(currentUser?.uid);

    late final CollectionReference<UserModel> userRef = FirebaseFirestore.instance.collection("users").withConverter<UserModel>(
      fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
      toFirestore: (user, _) => user.toJson(),
    );
    DocumentSnapshot<UserModel> user = await userRef.doc(currentUser?.uid).get();

    if (currentUser?.uid != null) {
      if (user.data() != null) {
        // Inizializzare la mappa se è null
        Map<String, List<double>> listaDellaSpesa = user.data()?.listaDellaSpesa ?? {};

        //Lista della spesa aggiornata
        listaDellaSpesa = aggiungiProdotto(listaDellaSpesa, prodotto.nome, quantita, prodotto.prezzo, quantita * prodotto.prezzo);

        //Carichiamo la lista in firestore
        await userDoc.update({
          'listaDellaSpesa': listaDellaSpesa,
        });
      } else {
        showSnackBar("Errore durante nell'inserimento del prodotto nella lista", context);
      }
    } else {
      showSnackBar("Utente non autenticato", context);
    }
  }


  //Metodo per aggiornare la lista della spesa
  Map<String, List<double>> aggiungiProdotto(Map<String, List<double>> lista,
      String prodotto, double quantita, double prezzoAlKg, double prezzo) {
    //Verifichiamo che il prodotto sia già nella lista
    if (lista.containsKey(prodotto)) {
      // Aggiorna la quantità
      lista[prodotto]![0] = quantita;
      //Aggiorna il prezzo
      lista[prodotto]![2] = quantita * prezzoAlKg;
      return lista;
    } else {
      // Aggiunge un nuovo prodotto con quantità e prezzo
      lista[prodotto] = [quantita, prezzoAlKg, prezzo];
      return lista;
    }
  }


  showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}
