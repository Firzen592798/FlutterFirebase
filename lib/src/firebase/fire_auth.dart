import 'package:flutter/material.dart';
import 'package:flutter_login/src/firebase/auth_service.dart';
import 'package:flutter_login/src/firebase/firebase_messaging_service.dart';
import 'package:flutter_login/src/firebase/main_fire_page.dart';
import 'package:flutter_login/src/firebase/login_page.dart';
import 'package:provider/provider.dart';

import 'notification_service.dart';

class FireAuth extends StatefulWidget {
  const FireAuth({super.key});

  @override
  State<FireAuth> createState() => _FireAuthState();
}

class _FireAuthState extends State<FireAuth> {

  @override
  void initState() {
    super.initState();
    initializeFirebaseMessaging();
    checkNotifications();
  }

  checkNotifications() async {
    await Provider.of<NotificationService>(context, listen: false).checkForNotifications();
  }

  initializeFirebaseMessaging() async{
    await Provider.of<FirebaseMessagingService>(context, listen: false).initialize();
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