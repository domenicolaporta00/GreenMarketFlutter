import 'package:firebase_auth/firebase_auth.dart';

//Classe che gestisce l'autenticazione mediante FirebaseAuth
class Auth{
  /*
  //Aperto un'istanza di FirebaseAuth che si occupa della gestione dell'autenticazione
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //Creazione dell'utente corrente
  User? get currentUser => _firebaseAuth.currentUser;
  //Stiamo in ascolto dei cambiamenti dello stato dell'autenticazione in modo che server ed app possano esserne entrambi sempre al corrente
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  //Login
  //Funzione indispensabile per chiamare la funzione dentro di Firebase,
  //poiché non abbiamo accesso diretto a _firebaseAuth.
  //Dobbiamo passare al metodo una mappa contente email e password
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async{
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  //Registrazione
  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async{
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  //Logout
  Future<void> signedOut() async{
    await _firebaseAuth.signOut();
  }
  */

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