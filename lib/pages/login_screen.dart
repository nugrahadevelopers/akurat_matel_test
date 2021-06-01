import 'package:akurat_matel/app_theme.dart';
import 'package:akurat_matel/pages/navigation_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:akurat_matel/providers/auth_provider.dart';
import 'package:akurat_matel/models/user_model.dart';
import 'package:akurat_matel/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart';

const users = const {
  'user1@user.com': '123456',
  'user2@user.com': '123456',
};

class LoginPage extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  // final Future<Map<String, dynamic>> successfulMessage = authProvider

  // Future<String> _authUser(LoginData data) {
  //   print('Name: ${data.name}, Password: ${data.password}');
  //   return Future.delayed(loginTime).then((_) {
  //     // if (!users.containsKey(data.name)) {
  //     //   return 'Username tidak ditemukan';
  //     // }
  //     // if (users[data.name] != data.password) {
  //     //   return 'Password salah!';
  //     // }
  //     // return null;
  //   });
  // }

  // Future<String> _recoverPassword(String name) {
  //   print('Name: $name');
  //   return Future.delayed(loginTime).then((_) {
  //     if (!users.containsKey(name)) {
  //       return 'Username tidak ditemukan';
  //     }
  //     return null;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    Future<String> _authUser(LoginData data) {
      print('Name: ${data.name}, Password: ${data.password}');

      final Future<Map<String, dynamic>> successfulMessage =
          authProvider.login(data.name, data.password);

      return Future.delayed(loginTime).then((_) {
        successfulMessage.then((response) {
          if (response['status']) {
            UserModel userModel = response['user'];
            Provider.of<UserProvider>(context, listen: false)
                .setUser(userModel);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => NavigationHomeScreen(),
            ));
          } else {
            Flushbar(
              title: 'Login Gagal!',
              message: response['message']['message'].toString(),
              duration: Duration(seconds: 3),
            ).show(context);
          }
        });
        // if (!users.containsKey(data.name)) {
        //   return 'Username tidak ditemukan';
        // }
        // if (users[data.name] != data.password) {
        //   return 'Password salah!';
        // }
        return null;
      });
    }

    Future<String> _recoverPassword(String name) {
      print('Name: $name');
      return Future.delayed(loginTime).then((_) {
        if (!users.containsKey(name)) {
          return 'Username tidak ditemukan';
        }
        return null;
      });
    }

    return FlutterLogin(
      title: 'Akurat Matel',
      logo: 'assets/images/ic_logo.png',
      onSignup: _authUser,
      onLogin: _authUser,
      onSubmitAnimationCompleted: () {
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //   builder: (context) => NavigationHomeScreen(),
        // ));
      },
      onRecoverPassword: _recoverPassword,
      hideForgotPasswordButton: true,
      hideSignUpButton: true,
      theme: LoginTheme(
        primaryColor: AppTheme.grey,
        accentColor: AppTheme.dark_grey,
        errorColor: Colors.deepOrange,
        titleStyle: TextStyle(
          color: AppTheme.white,
          fontFamily: 'Roboto',
          fontSize: 36.0,
        ),
        cardTheme: CardTheme(
          elevation: 5,
          margin: EdgeInsets.only(top: 15),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(100.0)),
        ),
      ),
    );
  }
}
