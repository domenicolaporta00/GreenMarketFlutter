import 'package:flutter/material.dart';

class HomePageViewModel extends ChangeNotifier {

  String _nome = "";
  String get nome => _nome;

  getNome() {
    String name = "Domenico";
    _nome = name;
    notifyListeners();
  }

  setNome(String nome) {
    _nome = nome;
    notifyListeners();
  }

}