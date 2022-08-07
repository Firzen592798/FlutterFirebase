import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/src/firebase/auth_service.dart';
import 'package:provider/provider.dart';

class FirePage extends StatefulWidget {

  const FirePage({super.key});

  @override
  State<FirePage> createState() => _FirePageState();
}

class _FirePageState extends State<FirePage> {
  int _likes = 0;

  like() async {
    _likesRef.set(ServerValue.increment(1));
  }

  late final DatabaseReference _likesRef;
  late StreamSubscription<DatabaseEvent> _likesSubscription;

  @override
  void initState() {
    super.initState();    
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    init();
  }

  @override
  void dispose(){
    _likesSubscription.cancel();
    super.dispose();
  }

  init() async{
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    _likesRef = FirebaseDatabase.instance.ref('likes').child(Provider.of<AuthService>(context).usuarioLogado!.uid);
    try{
      final likeSnapshot = await _likesRef.get();
      _likes = likeSnapshot.value as int;
    }catch(err){
      debugPrint(err.toString());
    }

    _likesSubscription = _likesRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        _likes = (event.snapshot.value ?? 0) as int;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => context.read<AuthService>().logout(), 
            icon: const Icon(Icons.logout)
          )
        ],
      ),
      body: Center(child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(onPressed: like, icon: const Icon(Icons.thumbs_up_down)),
          Text(_likes.toString(), style: const TextStyle(fontSize: 20))
        ],
      )
      )
    );
  }


}