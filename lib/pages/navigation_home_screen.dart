import 'package:akurat_matel/pages/profil_screen.dart';
import 'package:flutter/material.dart';
import 'package:akurat_matel/app_theme.dart';
import 'package:akurat_matel/pages/custom_drawer/drawer_user_controller.dart';
import 'package:akurat_matel/pages/custom_drawer/home_drawer.dart';
import 'package:akurat_matel/pages/home_screen.dart';

class NavigationHomeScreen extends StatefulWidget {
  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget screenView;
  DrawerIndex drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.Home;
    screenView = HomePage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.nearlyWhite,
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          backgroundColor: AppTheme.nearlyWhite,
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
            },
            screenView: screenView,
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.Home) {
        setState(() {
          screenView = HomePage();
        });
      } else if (drawerIndex == DrawerIndex.Profil) {
        setState(() {
          screenView = ProfilePage();
        });
      } else {}
    }
  }
}
