import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthException implements Exception{
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier{
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? usuarioLogado;
    bool isLoading = true;

    AuthService(){
      _authCheck();
    }

    _authCheck(){
      debugPrint("AuthCheck");
      _auth.authStateChanges().listen((User? user) {
        usuarioLogado = (user == null) ? null : user;
        isLoading = false;
        notifyListeners();
      });
    }
    
    registrar(String email, String senha) async{
      try {
        await _auth.createUserWithEmailAndPassword(email: email, password: senha);
        _getUser();
      } on FirebaseAuthException catch (e) {
        if(e.code == 'weak-password'){
          throw AuthException('Senha é muito fraca');
        }else if(e.code == 'email-already-in-use'){
          throw AuthException('Este email já está cadastrado');
        }
      }
    }

    setLoading(){
      isLoading = true;
      notifyListeners();
    }

    Future<UserCredential> loginGoogle() async {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    //usuarioLogado = googleAuth.accessToken;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }

    login(String email, String senha) async{
      //setLoading();
      try {
        await _auth.signInWithEmailAndPassword(email: email, password: senha);
        _getUser();
      } on FirebaseAuthException catch (e) {
        if(e.code == 'user-not-found'){
          throw AuthException('Email não encontrado');
        }else if(e.code == 'wrong-password'){
          throw AuthException('Senha incorreta');
        }
      }
    }

    logout() async{
      await _auth.signOut();
      _getUser();
    }

    _getUser(){
      usuarioLogado = _auth.currentUser;
      notifyListeners();
    }
}