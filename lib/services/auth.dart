import 'package:firebase_auth/firebase_auth.dart';

//Classe che gestisce l'autenticazione mediante FirebaseAuth
class Auth{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Metodo per registrare un nuovo utente
  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Metodo per fare il login di un utente esistente
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Metodo per recuperare la password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  // Metodo per fare il logout dell'utente
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  //Metodo che torna l'utente corrente
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Metodo per eliminare l'utente autenticato
  Future<void> deleteUser() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.delete();
      }
    } catch (e) {
      print(e.toString());
    }
  }

}