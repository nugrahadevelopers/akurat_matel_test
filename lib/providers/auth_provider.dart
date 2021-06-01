import 'dart:async';
import 'dart:convert';
// import 'dart:io';

import 'package:akurat_matel/util/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:akurat_matel/util/app_url.dart';
import 'package:http/http.dart';
import 'package:akurat_matel/models/user_model.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut,
}

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;

  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    var myUrl = Uri.parse(AppUrl.login);

    Response response = await get(myUrl,
        // body: json.encode(loginData),
        headers: {'content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      var userData = responseData['data'];

      UserModel authUser = UserModel.fromJson(userData);

      UserPreferences().saveUser(authUser);

      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {
        'status': true,
        'message': 'Successful',
        'user': authUser,
      };
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();

      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }

    return result;
  }

  static onError(error) {
    print("the error is $error.detail");
    return {
      'status': false,
      'message': 'Unsuccessful Request',
      'data': error,
    };
  }
}
