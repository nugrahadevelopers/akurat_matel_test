import 'package:flutter/widgets.dart';

class CarModel {
  String id;
  String noPol;
  String jenis;
  String finance;
  String cabang;
  String atasNama;
  String noKontrak;
  String noMesin;
  String noRangka;
  String warna;
  String overDue;
  String saldo;
  Widget navigateScreen;

  CarModel({
    this.id,
    this.noPol,
    this.jenis,
    this.finance,
    this.cabang,
    this.atasNama,
    this.noKontrak,
    this.noMesin,
    this.noRangka,
    this.warna,
    this.overDue,
    this.saldo,
    this.navigateScreen,
  });

  factory CarModel.fromJson(Map<String, dynamic> responseData) {
    return CarModel(
      id: responseData['id'],
      noPol: responseData['nopol'],
      jenis: responseData['jenis'],
      finance: responseData['finance'],
      cabang: responseData['cabang'],
      atasNama: responseData['atas_nama'],
      noKontrak: responseData['no_kontrak'],
      noMesin: responseData['no_mesin'],
      noRangka: responseData['no_rangka'],
      warna: responseData['warna'],
      overDue: responseData['over_due'],
      saldo: responseData['saldo'],
    );
  }

  Map<String, Object> toMap() {
    return {
      'id': id,
      'nopol': noPol,
      'jenis': jenis,
      'finance': finance,
      'cabang': cabang,
      'atas_nama': atasNama,
      'no_kontrak': noKontrak,
      'no_mesin': noMesin,
      'no_rangka': noRangka,
      'warna': warna,
      'over_due': overDue,
      'saldo': saldo,
    };
  }
}
