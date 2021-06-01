import 'package:akurat_matel/models/user_model.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  UserModel _userModel = new UserModel();

  UserModel get userModel => _userModel;

  void setUser(UserModel userModel) {
    _userModel = userModel;
    notifyListeners();
  }
}
