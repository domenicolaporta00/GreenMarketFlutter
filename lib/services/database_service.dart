import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/user_model.dart';

//Costante per accedere al db Firestore
const String USER_COLLECTION_REF = "users";

//Classe che gestisce l'utente a livello di database mediante Firebase Firestore
class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? uid;

  DatabaseService({required this.uid});

  //Riferimento alla raccolta "users" nel db Firestore
  late final CollectionReference<UserModel> _userRef = _firestore.collection(USER_COLLECTION_REF).withConverter<UserModel>(
    fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
    toFirestore: (user, _) => user.toJson(),
  );

  // Metodo per creare un nuovo documento utente
  Future<void> createUser(UserModel user) async {
    try {
      await _userRef.doc(uid).set(user);
    } catch (e) {
      print(e.toString());
    }
  }

  // Metodo per ottenere i dati dell'utente
  Future<UserModel?> getUser() async {
    try {
      DocumentSnapshot<UserModel> doc = await _userRef.doc(uid).get();
      return doc.data();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Metodo per modificare i dati anagrafici dell'utente
  Future<void> updateUser(UserModel user) async {
    try {
      await _userRef.doc(uid).update(user.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

  // Metodo per eliminare i dati dell'utente dal db
  Future<void> deleteUser() async {
    try {
      await _userRef.doc(uid).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}

