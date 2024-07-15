class UserModel {
  final String nome;
  final String cognome;
  final String indirizzo;
  final Map<String, List<double>> listaDellaSpesa;

  UserModel({
    required this.nome,
    required this.cognome,
    required this.indirizzo,
    required this.listaDellaSpesa,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      nome: json['nome'],
      cognome: json['cognome'],
      indirizzo: json['indirizzo'],
      listaDellaSpesa: (json['listaDellaSpesa'] as Map<String, dynamic>).map((key, value) {
        return MapEntry(key, List<double>.from(value));
      }),
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'nome': nome,
      'cognome': cognome,
      'indirizzo': indirizzo,
      'listaDellaSpesa': listaDellaSpesa,
    };
  }
}