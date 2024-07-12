class UserModel {
  final String nome;
  final String cognome;
  final String indirizzo;

  UserModel({
    required this.nome,
    required this.cognome,
    required this.indirizzo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      nome: json['nome'],
      cognome: json['cognome'],
      indirizzo: json['indirizzo'],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'nome': nome,
      'cognome': cognome,
      'indirizzo': indirizzo,
    };
  }

}