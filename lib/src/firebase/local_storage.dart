import 'package:shared_preferences/shared_preferences.dart';
class LocalStorage {



  Future<void> salvarDadosLogin(String uid) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("uid", uid);
  }

  Future<String?> getDadosLogin() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("uid");
  }

  void apagarDadosLogin() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("uid");
  }
}