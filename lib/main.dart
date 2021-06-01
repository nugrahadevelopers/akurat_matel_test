import 'dart:io';
import 'package:akurat_matel/app_theme.dart';
import 'package:akurat_matel/models/user_model.dart';
import 'package:akurat_matel/pages/login_screen.dart';
import 'package:akurat_matel/pages/navigation_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:akurat_matel/util/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:akurat_matel/providers/auth_provider.dart';
import 'package:akurat_matel/providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<UserModel> getUserData() => UserPreferences().getUser();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness:
            Platform.isAndroid ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.grey,
        systemNavigationBarIconBrightness: Brightness.dark));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Akurat Matel',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: AppTheme.textTheme,
          platform: TargetPlatform.android,
        ),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
            future: getUserData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.data.token == null) {
                    return LoginPage();
                  } else {
                    UserPreferences().removeUser();
                  }

                  return NavigationHomeScreen();
              }
            }),
        routes: {
          '/login': (context) => LoginPage(),
        },
      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
