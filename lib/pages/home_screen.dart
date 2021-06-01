import 'dart:convert';

import 'package:akurat_matel/models/car_model.dart';
import 'package:akurat_matel/pages/detail_kendaraan_screen.dart';
import 'package:akurat_matel/services/database_handler.dart';
import 'package:akurat_matel/util/app_url.dart';
import 'package:flutter/material.dart';
import 'package:akurat_matel/app_theme.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  DatabaseHandler handler;
  // bool isLoading = false;
  bool multiple = true;

  @override
  void initState() {
    super.initState();
    this.handler = DatabaseHandler();
    this.handler.initDB().whenComplete(() async {
      // setState(() {
      //   isLoading = true;
      // });
      await _fetchCar();
      setState(() {
        // isLoading = false;
      });
    });
  }

  Future<int> _fetchCar() async {
    var myURL = Uri.parse(AppUrl.kendaraan);
    var response = await http.get(myURL);

    if (response.statusCode == 200) {
      try {
        List jsonObject = json.decode(response.body)['data'];

        return await this
            .handler
            .insertCar(jsonObject.map((e) => CarModel.fromJson(e)).toList());
      } catch (error) {
        print('Error response: $error');
        return null;
      }
    } else {
      print('Failed to Load Coin from API');
      return null;
    }
  }

  FutureBuilder<List<CarModel>> buildFutureBuilder() {
    var maxWidth = 112.0;
    var width = MediaQuery.of(context).size.width;
    var columns = (width ~/ maxWidth) + 1;
    var columnWidth = width / columns;
    var aspectRatio = columnWidth / 136;

    return FutureBuilder(
        future: this.handler.retrieveCar(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            print('Snapshot Error: ${snapshot.error}');
            return const SizedBox();
          } else {
            return Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  appBar(),
                  Expanded(
                    child: FutureBuilder(
                      future: this.handler.retrieveCar(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox();
                        } else {
                          List<CarModel> data = snapshot.data;
                          return GridView(
                            padding: const EdgeInsets.only(
                                top: 0, left: 12, right: 12),
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            children: List<Widget>.generate(
                              data.length,
                              (int index) {
                                return HomeListView(
                                  listData: data[index],
                                  callBack: () {
                                    Navigator.push<dynamic>(
                                      context,
                                      MaterialPageRoute<dynamic>(
                                        builder: (context) =>
                                            DetailKendaraanPage(
                                                car: data[index]),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: multiple ? 2 : 1,
                              mainAxisExtent: maxWidth,
                              childAspectRatio: aspectRatio,
                            ),
                          );
                        }
                      },
                    ),
                  )
                ],
              ),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: buildFutureBuilder(),
    );
  }

  Widget appBar() {
    return SizedBox(
      height: AppBar().preferredSize.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Akurat Matel',
                  style: TextStyle(
                    fontSize: 22,
                    color: AppTheme.darkText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, right: 8),
            child: Container(
              width: AppBar().preferredSize.height - 8,
              height: AppBar().preferredSize.height - 8,
              color: Colors.white,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                      BorderRadius.circular(AppBar().preferredSize.height),
                  child: Icon(
                    multiple ? Icons.dashboard : Icons.view_agenda,
                    color: AppTheme.dark_grey,
                  ),
                  onTap: () {
                    setState(() {
                      multiple = !multiple;
                    });
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HomeListView extends StatelessWidget {
  const HomeListView({
    Key key,
    this.listData,
    this.callBack,
  }) : super(key: key);

  final CarModel listData;
  final VoidCallback callBack;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        cardDataKendaraan(),
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.grey.withOpacity(0.2),
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            onTap: () {
              callBack();
            },
          ),
        ),
      ],
    );
  }

  Card cardDataKendaraan() {
    return Card(
      elevation: 5,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5),
                child: Icon(Icons.account_box),
              ),
              Text('${listData.overDue} Hari'),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5),
                child: Icon(Icons.account_box),
              ),
              Text(listData.noPol),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5),
                child: Icon(Icons.account_box),
              ),
              Flexible(child: Text(listData.jenis)),
            ],
          ),
        ],
      ),
    );
  }
}
