import 'package:akurat_matel/pages/detail_kendaraan_screen.dart';
import 'package:flutter/widgets.dart';

class HomeList {
  HomeList({
    this.navigateScreen,
    this.tanggalTempo,
    this.noPol,
    this.merkKendaraan,
  });

  Widget navigateScreen;
  String tanggalTempo;
  String noPol;
  String merkKendaraan;

  static List<HomeList> homeList = [
    HomeList(
      tanggalTempo: '11-Mei-2021',
      noPol: 'BA7037BN',
      merkKendaraan: 'TERIOS',
      navigateScreen: DetailKendaraanPage(),
    ),
    HomeList(
      tanggalTempo: '11-Mei-2021',
      noPol: 'BK1535UG',
      merkKendaraan: 'XENIA',
      navigateScreen: DetailKendaraanPage(),
    ),
    HomeList(
      tanggalTempo: '11-Mei-2021',
      noPol: 'BK1634FY',
      merkKendaraan: 'AVANZA',
      navigateScreen: DetailKendaraanPage(),
    ),
  ];
}
