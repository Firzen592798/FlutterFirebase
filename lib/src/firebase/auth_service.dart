import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

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
      usuarioLogado= _auth.currentUser;
      notifyListeners();
    }
}