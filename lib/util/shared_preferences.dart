import 'package:akurat_matel/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool> saveUser(UserModel userModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("uId", userModel.uId);
    prefs.setString("name", userModel.name);
    prefs.setString("email", userModel.email);
    prefs.setString("noHp", userModel.noHp);
    prefs.setString("lokasi", userModel.lokasi);
    prefs.setString("masaAktif", userModel.masaAktif);
    prefs.setString("tipe", userModel.tipe);
    prefs.setString("token", userModel.token);
    prefs.setString("renewalToken", userModel.renewalToken);

    print("object prefere");
    print(userModel.renewalToken);

    return true;
  }

  Future<UserModel> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int uId = prefs.getInt("uId");
    String name = prefs.getString("name");
    String email = prefs.getString("email");
    String noHp = prefs.getString("noHp");
    String lokasi = prefs.getString("lokasi");
    String masaAktif = prefs.getString("masaAktif");
    String tipe = prefs.getString("tipe");
    String token = prefs.getString("token");
    String renewalToken = prefs.getString("renewalToken");

    return UserModel(
      uId: uId,
      name: name,
      email: email,
      noHp: noHp,
      lokasi: lokasi,
      masaAktif: masaAktif,
      tipe: tipe,
      token: token,
      renewalToken: renewalToken,
    );
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("noHp");
    prefs.remove("lokasi");
    prefs.remove("masaAktif");
    prefs.remove("tipe");
    prefs.remove("token");
  }

  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = prefs.getString("token");

    return token;
  }
}
