import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/product_model.dart';
import '../../model/user_model.dart';
import '../../services/database_service.dart';

class HomePageViewModel extends ChangeNotifier {

  String _nome = "";
  String get nome => _nome;

  String _status = "";
  String get status => _status;

  String _orari = "";
  String get orari => _orari;

  Color _colore = Colors.red;
  Color get colore => _colore;

  List<ProductModel> _listaProdotti = [];
  List<ProductModel> get listaProdotti => _listaProdotti;

  Future<void> getNome() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      DatabaseService databaseService = DatabaseService(uid: currentUser.uid);
      UserModel? userData = await databaseService.getUser();
      _nome = userData!.nome;
    }
    notifyListeners();
  }

  Future<List<ProductModel>> getProdottiRandom() async {
    try {
      // Recupera la raccolta 'product' da Firestore
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('products').get();

      // Converte ogni documento in un oggetto ProdottoModel
      List<ProductModel> prodotti = querySnapshot.docs.map((doc) {
        // Usa il metodo fromFirestore per convertire la mappa in un oggetto ProdottoModel
        return ProductModel.fromDocument(doc);
      }).toList();

      List<ProductModel> prodRand = [];
      Random rand = Random();
      while(prodRand.length < 6) {
        int randomIndex = rand.nextInt(prodotti.length);
        if(!prodRand.contains(prodotti[randomIndex])) {
          prodRand.add(prodotti[randomIndex]);
        }
      }
      _listaProdotti = prodRand;
      return prodRand;

    } catch (e) {
      print("Errore nel recuperare i prodotti: $e");
      return [];
    }
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