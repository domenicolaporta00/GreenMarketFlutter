import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String nome;
  final String descrizione;
  final double prezzo;
  final String foto;

  ProductModel({
    required this.nome,
    required this.descrizione,
    required this.prezzo,
    required this.foto,
  });

  factory ProductModel.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      nome: data['nome'] ?? '',
      descrizione: data['descrizione'] ?? '',
      prezzo: data['prezzo'] is int ? (data['prezzo'] as int).toDouble() : data['prezzo'] ?? 0.0,
      foto: data['foto'] ?? '',
    );
  }
}