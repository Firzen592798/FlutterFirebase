import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login/src/firebase/auth_service.dart';
import 'package:flutter_login/src/firebase/fire_page.dart';
import 'package:flutter_login/src/firebase/login_page.dart';
import 'package:provider/provider.dart';

class FireAuth extends StatefulWidget {
  const FireAuth({super.key});

  @override
  State<FireAuth> createState() => _FireAuthState();
}

class _FireAuthState extends State<FireAuth> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService> (context);
    if(authService.isLoading){
      return loading();
    }else if(authService.usuarioLogado == null){
      return const LoginPage();
    }else{
      return const FirePage();
    }


  }
  
  loading(){
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}