import 'package:akurat_matel/models/car_model.dart';
import 'package:flutter/material.dart';

class DetailKendaraanPage extends StatelessWidget {
  final CarModel car;

  DetailKendaraanPage({Key key, this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(car.noPol),
        ),
        body: Text(car.noMesin),
      ),
    );
  }
}
