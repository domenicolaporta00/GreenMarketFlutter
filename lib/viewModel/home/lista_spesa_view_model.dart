import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:green_market_flutter/model/product_model.dart';
import 'package:green_market_flutter/model/product_in_shopping_list_model.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';

class ListaSpesaViewModel extends ChangeNotifier {

  User? currentUser = FirebaseAuth.instance.currentUser;

  List<ProductInShoppingList> _listaProdotti = [];
  List<ProductInShoppingList> get listaProdotti => _listaProdotti;

  late ProductModel _prodottoDettagliato = ProductModel(nome: "", descrizione: "", prezzo: 0.0, foto: "");
  ProductModel get prodottoDettagliato => _prodottoDettagliato;

  double _totale = 0.0;
  double get totale => _totale;

  Future<List<ProductInShoppingList>> getListaDellaSpesa() async {
    try {
      late final CollectionReference<UserModel> userRef = FirebaseFirestore
          .instance.collection("users").withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );
      DocumentSnapshot<UserModel> user = await userRef.doc(currentUser?.uid)
          .get();

      if (currentUser?.uid != null) {
        if (user.data() != null) {
          // Inizializzare la mappa se è null
          Map<String, List<double>> listaDellaSpesa = user.data()?.listaDellaSpesa ?? {};

          List<ProductInShoppingList> listaConvertita = convertiMapInLista(listaDellaSpesa);
          _listaProdotti = listaConvertita;
          getTotale();
        }
      }
      notifyListeners();
      return listaProdotti;
    }catch (e) {
      print("Errore nel recuperare i prodotti: $e");
      return [];
    }
  }

  //Metodo che converte la lista della spesa (Map) presa dal db firestore in una List<ProdottoInListaModel>
  List<ProductInShoppingList> convertiMapInLista(Map<String, List<double>> map) {
    List<ProductInShoppingList> listaProdotti = [];

    map.forEach((nomeProdotto, valori) {
      double quantita = valori[0];
      double prezzoAlKg = valori[1];
      double prezzoTotale = valori[2];

      ProductInShoppingList prodotto = ProductInShoppingList(
        nome: nomeProdotto,
        quantita: quantita,
        prezzoAlKg: prezzoAlKg,
        prezzoTotale: arrotonda(prezzoTotale, 2),
      );

      listaProdotti.add(prodotto);
    });

    return listaProdotti;
  }

  //Metodo che converte una List<ProdottoInListaModel> in una lista della spesa (Map) presa dal db firestore
  Map<String, List<double>> convertiListaInMap(List<ProductInShoppingList> listaProdotti) {
    Map<String, List<double>> map = {};

    for (var prodotto in listaProdotti) {
      String nomeProdotto = prodotto.nome;
      double quantita = prodotto.quantita;
      double prezzoAlKg = prodotto.prezzoAlKg;
      double prezzoTotale = prodotto.prezzoTotale;

      map[nomeProdotto] = [quantita, prezzoAlKg, prezzoTotale];
    }

    return map;
  }


  getProdottoByNome(ProductInShoppingList prod) async{
    ProductInShoppingList prodotto = listaProdotti.firstWhere((p)=>p.nome == prod.nome);
    try {
      final productDoc = await FirebaseFirestore.instance.collection('products').doc(prodotto.nome).get();

      if (productDoc.exists) {
        _prodottoDettagliato = ProductModel.fromDocument(productDoc);
        notifyListeners();
      } else {
        print("Prodotto non trovato");
      }
    } catch (e) {
      print("Errore nella ricerca del prodotto: $e");
    }

  }


  Future<void> deleteListaSpesa() async {
    final DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(currentUser?.uid);

    //Aggiorna la lista della spesa a vuota
    await userDoc.update({
      'listaDellaSpesa': {},
    });

    // Attendo il calcolo del totale
    await getTotale();
  }


  Future<void> deleteByName(String nome) async{
    final DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(currentUser?.uid);

    listaProdotti.removeWhere((prod) => prod.nome == nome);
    Map<String, List<double>> listaDellaSpesa = convertiListaInMap(listaProdotti);

    //Aggiorna la lista della spesa a vuota
    await userDoc.update({
      'listaDellaSpesa': listaDellaSpesa,
    });

    await getTotale();
    notifyListeners();
  }

  getTotale() {
    double tot = 0.0;
    for(var i in _listaProdotti) {
      tot = tot + i.prezzoTotale;
    }
    _totale = arrotonda(tot, 2);
    notifyListeners();
  }

  //Funzione per arrotondare ad un certo numero di decimali
  double arrotonda(double valore, int decimali) {
    int fattore = pow(10, decimali).toInt();
    return (valore * fattore).round() / fattore;
  }

  showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}