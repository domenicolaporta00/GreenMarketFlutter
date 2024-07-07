import 'dart:ui';

import 'package:flutter/material.dart';

class HomePageViewModel extends ChangeNotifier {

  String _nome = "";
  String get nome => _nome;

  String _status = "";
  String get status => _status;

  String _orari = "";
  String get orari => _orari;

  Color _colore = Colors.red;
  Color get colore => _colore;

  getNome() {
    String name = "Domenico";
    _nome = name;
    notifyListeners();
  }

  setNome(String nome) {
    _nome = nome;
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