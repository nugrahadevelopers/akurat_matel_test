import 'package:akurat_matel/model/homelist.dart';
import 'package:flutter/material.dart';
import 'package:akurat_matel/app_theme.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<HomeList> homeList = HomeList.homeList;
  // AnimationController animationController;
  bool multiple = true;

  // @override
  // void initState() {
  //   animationController = AnimationController(
  //       duration: const Duration(milliseconds: 2000), vsync: this);
  //   super.initState();
  // }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  // @override
  // void dispose() {
  //   animationController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var maxWidth = 112.0;
    var width = MediaQuery.of(context).size.width;
    var columns = (width ~/ maxWidth) + 1;
    var columnWidth = width / columns;
//136 is the height of one grid item
    var aspectRatio = columnWidth / 136;

    return Scaffold(
      backgroundColor: AppTheme.white,
      body: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
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
                    child: FutureBuilder<bool>(
                      future: getData(),
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        if (!snapshot.hasData) {
                          return const SizedBox();
                        } else {
                          return GridView(
                            padding: const EdgeInsets.only(
                                top: 0, left: 12, right: 12),
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            children: List<Widget>.generate(
                              homeList.length,
                              (int index) {
                                // final int count = homeList.length;
                                // final Animation<double> animation =
                                //     Tween<double>(begin: 0.0, end: 1.0)
                                //         .animate(CurvedAnimation(
                                //   parent: animationController,
                                //   curve: Interval((1 / count) * index, 1.0,
                                //       curve: Curves.fastOutSlowIn),
                                // ));
                                // animationController.forward();
                                return HomeListView(
                                  // animation: animation,
                                  // animationController: animationController,
                                  listData: homeList[index],
                                  callBack: () {
                                    Navigator.push<dynamic>(
                                      context,
                                      MaterialPageRoute<dynamic>(
                                        builder: (BuildContext context) =>
                                            homeList[index].navigateScreen,
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
        },
      ),
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
    // this.animationController,
    // this.animation
  }) : super(key: key);

  final HomeList listData;
  final VoidCallback callBack;
  // final AnimationController animationController;
  // final Animation<dynamic> animation;

  // @override
  // Widget build(BuildContext context) {
  //   return AnimatedBuilder(
  //     animation: animationController,
  //     builder: (BuildContext context, Widget child) {
  //       return FadeTransition(
  //         opacity: animation,
  //         child: Transform(
  //           transform: Matrix4.translationValues(
  //               0.0, 50 * (1.0 - animation.value), 0.0),
  //           child: AspectRatio(
  //             aspectRatio: 1.5,
  //             child: ClipRRect(
  //               borderRadius: const BorderRadius.all(Radius.circular(4.0)),
  //               child: Stack(
  //                 alignment: AlignmentDirectional.center,
  //                 children: <Widget>[
  //                   cardDataKendaraan(),
  //                   Material(
  //                     color: Colors.transparent,
  //                     child: InkWell(
  //                       splashColor: Colors.grey.withOpacity(0.2),
  //                       borderRadius:
  //                           const BorderRadius.all(Radius.circular(4.0)),
  //                       onTap: () {
  //                         callBack();
  //                       },
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );

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
              Text(listData.tanggalTempo),
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
              Text(listData.merkKendaraan),
            ],
          ),
        ],
      ),
    );
  }
}
