import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/src/firebase/notification_service.dart';

class FirebaseMessagingService {
  final NotificationService _notificationService;

  FirebaseMessagingService(this._notificationService);

  Future<void> initialize() async{
    //Seta como a notificação vai aparecer se o app tiver aberto
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
      alert: true,
    );
    //Cada notificação vai gerar um token
    getDeviceFirebaseToken();
    _onMessage();
  }

  getDeviceFirebaseToken() async{
    final token = await FirebaseMessaging.instance.getToken();
    debugPrint('Token: $token'); 
  }

  //define os comportamentos para o recebimento da mensagem, exceto quando o app tá fechado
  _onMessage(){
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if(notification != null && android != null){
        _notificationService.showLocalNotification(
          CustomNotification(id: android.hashCode, title: notification.title!, body: notification.body!, payload: message.data['route'] ?? '')
        );
      }
    });
  }

  _onMessageOpenedApp(){
    FirebaseMessaging.onMessageOpenedApp.listen(_goToPageAfterMessage);
  }

  _goToPageAfterMessage(message){
    final String route = message.data['route'] ?? '';
    if(route.isNotEmpty){
      debugPrint(route);
      //Routes.navigatorKey?.currentState?.pushNamed(route);
    }
  }
}