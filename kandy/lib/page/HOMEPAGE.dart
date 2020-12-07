import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' hide NestedScrollView;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:kandy/homescreen/button_dpad.dart';
import 'package:kandy/details/tvdetails.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:kandy/homescreen/carousel.dart';
import 'package:kandy/player/internal_videoplayer.dart';
import 'package:optimized_cached_image/image_cache_manager.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';

class Homepage extends StatefulWidget {
  Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Homepagepage(),
    );
  }
}

class Homepagepage extends StatefulWidget {
  Homepagepage({Key key}) : super(key: key);

  @override
  _HomepagepageState createState() => _HomepagepageState();
}

class _HomepagepageState extends State<Homepagepage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  ScrollController sc = ScrollController();
  bool show = true;
  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  Future _data;
  Future getHomepage() async {
    var firestore = Firestore.instance;
    QuerySnapshot gh = await firestore.collection('Homepage').getDocuments();
    return gh.documents;
  }

  navigatetotvdetails(DocumentSnapshot tv) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Tvdetails(tv: tv)));
  }

  navigatetoplayerdetails(String url) {
    String result = url.replaceAll("vlc://", "");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InternalVideoplayerPage(url: result)));
  }

  Future<Directory> path() async => (await getExternalCacheDirectories())[0];

  @override
  void initState() {
    super.initState();
    myScroll();
    ImageCacheManager.init(ImageCacheConfig(
        widthKey: "custom-width",
        heightKey: "custom-height",
        storagePath: path(),
        enableLog: !kReleaseMode));
    initUser();
    _data = getHomepage();
  }

  void showtitleBar() {
    setState(() {
      show = true;
    });
  }

  void hidetitleBar() {
    setState(() {
      show = false;
    });
  }

  void myScroll() async {
    sc.addListener(() {
      if (sc.position.userScrollDirection == ScrollDirection.reverse) {
        hidetitleBar();
      }
      if (sc.position.userScrollDirection == ScrollDirection.forward) {
        showtitleBar();
      }
    });
  }

  @override
  void dispose() {
    sc.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);

    final double itemhdHeight = scaler.getHeight(2);
    final double itemLandscapecarouselHeight = scaler.getHeight(35);
    final double itemLandscapeHeight = scaler.getHeight(22);
    final double itemWidth = scaler.getWidth(100);

    return Container(
      color: Colors.black,
      child: Container(
        color: Colors.black,
        child: FutureBuilder(
          future: _data,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Scaffold(
                  resizeToAvoidBottomPadding: false,
                  backgroundColor: Colors.black,
                  body: Center(
                      child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Colors.redAccent[700]),
                  )));
            else {
              return NestedScrollView(
                controller: sc,
                headerSliverBuilder: (BuildContext c, bool f) {
                  return <Widget>[
                    SliverAppBar(
                      leading: Container(
                        height: 0.0,
                        width: 0.0,
                      ),
                      backgroundColor: Colors.black,
                      floating: true,
                      expandedHeight: itemLandscapecarouselHeight,
                      flexibleSpace: FlexibleSpaceBar(
                        stretchModes: [StretchMode.zoomBackground],
                        collapseMode: CollapseMode.parallax,
                        background: POSTER2(),
                      ),
                    ),
                  ];
                },
                body: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: itemhdHeight,
                              color: Colors.black,
                              width: itemWidth,
                              child: Text(snapshot.data[index].data['hd'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10)),
                            ),
                            Container(
                              height: itemLandscapeHeight,
                              color: Colors.black,
                              width: itemWidth,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: <Widget>[
                                    HomeRow2(
                                      ontap: () {
                                        navigatetoplayerdetails(
                                            snapshot.data[index].data['aa']);
                                      },
                                      imageUrl: snapshot.data[index].data['a'],
                                    ),
                                    HomeRow2(
                                      ontap: () {
                                        navigatetoplayerdetails(
                                            snapshot.data[index].data['bb']);
                                      },
                                      imageUrl: snapshot.data[index].data['b'],
                                    ),
                                    HomeRow2(
                                      ontap: () {
                                        navigatetoplayerdetails(
                                            snapshot.data[index].data['cc']);
                                      },
                                      imageUrl: snapshot.data[index].data['c'],
                                    ),
                                    HomeRow2(
                                      ontap: () {
                                        navigatetoplayerdetails(
                                            snapshot.data[index].data['dd']);
                                      },
                                      imageUrl: snapshot.data[index].data['d'],
                                    ),
                                    HomeRow2(
                                      ontap: () {
                                        navigatetoplayerdetails(
                                            snapshot.data[index].data['ee']);
                                      },
                                      imageUrl: snapshot.data[index].data['e'],
                                    ),
                                    HomeRow2(
                                      ontap: () {
                                        navigatetoplayerdetails(
                                            snapshot.data[index].data['ff']);
                                      },
                                      imageUrl: snapshot.data[index].data['f'],
                                    ),
                                    HomeRow2(
                                      ontap: () {
                                        navigatetoplayerdetails(
                                            snapshot.data[index].data['gg']);
                                      },
                                      imageUrl: snapshot.data[index].data['g'],
                                    ),
                                    // HomeRow2(
                                    //   ontap: () {
                                    //     navigatetoplayerdetails(
                                    //         snapshot.data[index]);
                                    //   },
                                    //   imageUrl: snapshot.data[index].data['h'],
                                    //   videoUrl: snapshot.data[index].data['hh'],
                                    // ),
                                    // HomeRow2(
                                    //   ontap: () {
                                    //     navigatetoplayerdetails(
                                    //         snapshot.data[index]);
                                    //   },
                                    //   imageUrl: snapshot.data[index].data['i'],
                                    //   videoUrl: snapshot.data[index].data['ii'],
                                    // ),
                                    // HomeRow2(
                                    //   ontap: () {
                                    //     navigatetoplayerdetails(
                                    //         snapshot.data[index]);
                                    //   },
                                    //   imageUrl: snapshot.data[index].data['j'],
                                    //   videoUrl: snapshot.data[index].data['jj'],
                                    // ),
                                    // HomeRow2(
                                    //   ontap: () {
                                    //     navigatetoplayerdetails(
                                    //         snapshot.data[index]);
                                    //   },
                                    //   imageUrl: snapshot.data[index].data['k'],
                                    //   videoUrl: snapshot.data[index].data['kk'],
                                    // ),
                                    // HomeRow2(
                                    //   ontap: () {
                                    //     navigatetoplayerdetails(
                                    //         snapshot.data[index]);
                                    //   },
                                    //   imageUrl: snapshot.data[index].data['l'],
                                    //   videoUrl: snapshot.data[index].data['ll'],
                                    // ),
                                    // HomeRow2(
                                    //   ontap: () {
                                    //     navigatetoplayerdetails(
                                    //         snapshot.data[index]);
                                    //   },
                                    //   imageUrl: snapshot.data[index].data['m'],
                                    //   videoUrl: snapshot.data[index].data['mm'],
                                    // ),
                                    // HomeRow2(
                                    //   ontap: () {
                                    //     navigatetoplayerdetails(
                                    //         snapshot.data[index]);
                                    //   },
                                    //   imageUrl: snapshot.data[index].data['n'],
                                    //   videoUrl: snapshot.data[index].data['nn'],
                                    // ),
                                    // HomeRow2(
                                    //   ontap: () {
                                    //     navigatetoplayerdetails(
                                    //         snapshot.data[index]);
                                    //   },
                                    //   imageUrl: snapshot.data[index].data['o'],
                                    //   videoUrl: snapshot.data[index].data['oo'],
                                    // ),
                                    // HomeRow2(
                                    //   ontap: () {
                                    //     navigatetoplayerdetails(
                                    //         snapshot.data[index]);
                                    //   },
                                    //   imageUrl: snapshot.data[index].data['p'],
                                    //   videoUrl: snapshot.data[index].data['pp'],
                                    // ),
                                    // HomeRow2(
                                    //   ontap: () {
                                    //     navigatetoplayerdetails(
                                    //         snapshot.data[index]);
                                    //   },
                                    //   imageUrl: snapshot.data[index].data['q'],
                                    //   videoUrl: snapshot.data[index].data['qq'],
                                    // ),
                                    // HomeRow2(
                                    //   ontap: () {
                                    //     navigatetoplayerdetails(
                                    //         snapshot.data[index]);
                                    //   },
                                    //   imageUrl: snapshot.data[index].data['r'],
                                    //   videoUrl: snapshot.data[index].data['rr'],
                                    // ),
                                    // HomeRow2(
                                    //   ontap: () {
                                    //     navigatetoplayerdetails(
                                    //         snapshot.data[index]);
                                    //   },
                                    //   imageUrl: snapshot.data[index].data['s'],
                                    //   videoUrl: snapshot.data[index].data['ss'],
                                    // ),
                                    // HomeRow2(
                                    //   ontap: () {
                                    //     navigatetoplayerdetails(
                                    //         snapshot.data[index]);
                                    //   },
                                    //   imageUrl: snapshot.data[index].data['t'],
                                    //   videoUrl: snapshot.data[index].data['tt'],
                                    // ),
                                    // HomeRow2(
                                    //   ontap: () {
                                    //     navigatetoplayerdetails(
                                    //         snapshot.data[index]);
                                    //   },
                                    //   imageUrl: snapshot.data[index].data['u'],
                                    //   videoUrl: snapshot.data[index].data['uu'],
                                    // ),
                                    // HomeRow2(
                                    //   ontap: () {
                                    //     navigatetoplayerdetails(
                                    //         snapshot.data[index]);
                                    //   },
                                    //   imageUrl: snapshot.data[index].data['v'],
                                    //   videoUrl: snapshot.data[index].data['vv'],
                                    // ),
                                    // HomeRow2(
                                    //   ontap: () {
                                    //     navigatetoplayerdetails(
                                    //         snapshot.data[index]);
                                    //   },
                                    //   imageUrl: snapshot.data[index].data['w'],
                                    //   videoUrl: snapshot.data[index].data['ww'],
                                    // ),
                                    // HomeRow2(
                                    //   ontap: () {
                                    //     navigatetoplayerdetails(
                                    //         snapshot.data[index]);
                                    //   },
                                    //   imageUrl: snapshot.data[index].data['x'],
                                    //   videoUrl: snapshot.data[index].data['xx'],
                                    // ),
                                    // HomeRow2(
                                    //   ontap: () {
                                    //     navigatetoplayerdetails(
                                    //         snapshot.data[index]);
                                    //   },
                                    //   imageUrl: snapshot.data[index].data['y'],
                                    //   videoUrl: snapshot.data[index].data['yy'],
                                    // ),
                                    // HomeRow2(
                                    //   ontap: () {
                                    //     navigatetoplayerdetails(
                                    //         snapshot.data[index]);
                                    //   },
                                    //   imageUrl: snapshot.data[index].data['z'],
                                    //   videoUrl: snapshot.data[index].data['zz'],
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              );
            }
          },
        ),
      ),
    );
  }
}

class Homepagep extends StatefulWidget {
  Homepagep({Key key}) : super(key: key);

  @override
  _HomepagepState createState() => _HomepagepState();
}

class _HomepagepState extends State<Homepagep> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Homepageppage(),
    );
  }
}

class Homepageppage extends StatefulWidget {
  Homepageppage({Key key}) : super(key: key);

  @override
  _HomepageppageState createState() => _HomepageppageState();
}

class _HomepageppageState extends State<Homepageppage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  ScrollController sc = ScrollController();
  bool show = true;
  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  Future _data;
  Future getHomepage() async {
    var firestore = Firestore.instance;
    QuerySnapshot gh = await firestore.collection('Homepage').getDocuments();
    return gh.documents;
  }

  navigatetotvdetails(DocumentSnapshot tv) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Tvdetails(tv: tv)));
  }

  navigatetoplayerdetails(String url) {
    String result = url.replaceAll("vlc://", "");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InternalVideoplayerPage(url: result)));
  }

  Future<Directory> path() async => (await getExternalCacheDirectories())[0];

  @override
  void initState() {
    super.initState();
    myScroll();
    ImageCacheManager.init(ImageCacheConfig(
        widthKey: "custom-width",
        heightKey: "custom-height",
        storagePath: path(),
        enableLog: !kReleaseMode));
    initUser();
    _data = getHomepage();
  }

  void showtitleBar() {
    setState(() {
      show = true;
    });
  }

  void hidetitleBar() {
    setState(() {
      show = false;
    });
  }

  void myScroll() async {
    sc.addListener(() {
      if (sc.position.userScrollDirection == ScrollDirection.reverse) {
        hidetitleBar();
      }
      if (sc.position.userScrollDirection == ScrollDirection.forward) {
        showtitleBar();
      }
    });
  }

  @override
  void dispose() {
    sc.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    final double itempotraitappbarHeight = scaler.getHeight(17);
    final double itempotraitcarouselHeight = scaler.getHeight(25);
    final double itemWidth = scaler.getWidth(100);
    final double itemhdHeight = scaler.getHeight(2);

    return Container(
      color: Colors.black,
      child: Container(
        color: Colors.black,
        child: FutureBuilder(
          future: _data,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Scaffold(
                  resizeToAvoidBottomPadding: false,
                  backgroundColor: Colors.black,
                  body: Center(
                      child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Colors.redAccent[700]),
                  )));
            else {
              return NestedScrollView(
                controller: sc,
                headerSliverBuilder: (BuildContext c, bool f) {
                  return <Widget>[
                    SliverAppBar(
                      leading: Container(height: 0.0, width: 0.0),
                      backgroundColor: Colors.transparent,
                      floating: true,
                      expandedHeight: itempotraitcarouselHeight,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        stretchModes: [StretchMode.zoomBackground],
                        background: POSTER(),
                      ),
                    ),
                  ];
                },
                body: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: itemhdHeight,
                              color: Colors.black,
                              width: itemWidth,
                              child: Text(snapshot.data[index].data['hd'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17)),
                            ),
                            Container(
                              height: itempotraitappbarHeight,
                              color: Colors.black,
                              width: itemWidth,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: <Widget>[
                                    HomeRow(
                                      ontap: () {
                                        navigatetoplayerdetails(
                                            snapshot.data[index].data['aa']);
                                      },
                                      imageUrl: snapshot.data[index].data['a'],
                                    ),
                                    HomeRow(
                                      ontap: () {
                                        navigatetoplayerdetails(
                                            snapshot.data[index].data['bb']);
                                      },
                                      imageUrl: snapshot.data[index].data['b'],
                                    ),
                                    HomeRow(
                                      ontap: () {
                                        navigatetoplayerdetails(
                                            snapshot.data[index].data['cc']);
                                      },
                                      imageUrl: snapshot.data[index].data['c'],
                                    ),
                                    HomeRow(
                                      ontap: () {
                                        navigatetoplayerdetails(
                                            snapshot.data[index].data['dd']);
                                      },
                                      imageUrl: snapshot.data[index].data['d'],
                                    ),
                                    HomeRow(
                                      ontap: () {
                                        navigatetoplayerdetails(
                                            snapshot.data[index].data['ee']);
                                      },
                                      imageUrl: snapshot.data[index].data['e'],
                                    ),
                                    HomeRow(
                                      ontap: () {
                                        navigatetoplayerdetails(
                                            snapshot.data[index].data['ff']);
                                      },
                                      imageUrl: snapshot.data[index].data['f'],
                                    ),
                                    HomeRow(
                                      ontap: () {
                                        navigatetoplayerdetails(
                                            snapshot.data[index].data['gg']);
                                      },
                                      imageUrl: snapshot.data[index].data['g'],
                                    ),
                                    // HomeRow(
                                    //   imageUrl:
                                    //       snapshot.data[index].data['h'],
                                    //   videoUrl:
                                    //       snapshot.data[index].data['hh'],
                                    // ),
                                    // HomeRow(
                                    //   imageUrl:
                                    //       snapshot.data[index].data['i'],
                                    //   videoUrl:
                                    //       snapshot.data[index].data['ii'],
                                    // ),
                                    // HomeRow(
                                    //   imageUrl:
                                    //       snapshot.data[index].data['j'],
                                    //   videoUrl:
                                    //       snapshot.data[index].data['jj'],
                                    // ),
                                    // HomeRow(
                                    //   imageUrl:
                                    //       snapshot.data[index].data['k'],
                                    //   videoUrl:
                                    //       snapshot.data[index].data['kk'],
                                    // ),
                                    // HomeRow(
                                    //   imageUrl:
                                    //       snapshot.data[index].data['l'],
                                    //   videoUrl:
                                    //       snapshot.data[index].data['ll'],
                                    // ),
                                    // HomeRow(
                                    //   imageUrl:
                                    //       snapshot.data[index].data['m'],
                                    //   videoUrl:
                                    //       snapshot.data[index].data['mm'],
                                    // ),
                                    // HomeRow(
                                    //   imageUrl:
                                    //       snapshot.data[index].data['n'],
                                    //   videoUrl:
                                    //       snapshot.data[index].data['nn'],
                                    // ),
                                    // HomeRow(
                                    //   imageUrl:
                                    //       snapshot.data[index].data['o'],
                                    //   videoUrl:
                                    //       snapshot.data[index].data['oo'],
                                    // ),
                                    // HomeRow(
                                    //   imageUrl:
                                    //       snapshot.data[index].data['p'],
                                    //   videoUrl:
                                    //       snapshot.data[index].data['pp'],
                                    // ),
                                    // HomeRow(
                                    //   imageUrl:
                                    //       snapshot.data[index].data['q'],
                                    //   videoUrl:
                                    //       snapshot.data[index].data['qq'],
                                    // ),
                                    // HomeRow(
                                    //   imageUrl:
                                    //       snapshot.data[index].data['r'],
                                    //   videoUrl:
                                    //       snapshot.data[index].data['rr'],
                                    // ),
                                    // HomeRow(
                                    //   imageUrl:
                                    //       snapshot.data[index].data['s'],
                                    //   videoUrl:
                                    //       snapshot.data[index].data['ss'],
                                    // ),
                                    // HomeRow(
                                    //   imageUrl:
                                    //       snapshot.data[index].data['t'],
                                    //   videoUrl:
                                    //       snapshot.data[index].data['tt'],
                                    // ),
                                    // HomeRow(
                                    //   imageUrl:
                                    //       snapshot.data[index].data['u'],
                                    //   videoUrl:
                                    //       snapshot.data[index].data['uu'],
                                    // ),
                                    // HomeRow(
                                    //   imageUrl:
                                    //       snapshot.data[index].data['v'],
                                    //   videoUrl:
                                    //       snapshot.data[index].data['vv'],
                                    // ),
                                    // HomeRow(
                                    //   imageUrl:
                                    //       snapshot.data[index].data['w'],
                                    //   videoUrl:
                                    //       snapshot.data[index].data['ww'],
                                    // ),
                                    // HomeRow(
                                    //   imageUrl:
                                    //       snapshot.data[index].data['x'],
                                    //   videoUrl:
                                    //       snapshot.data[index].data['xx'],
                                    // ),
                                    // HomeRow(
                                    //   imageUrl:
                                    //       snapshot.data[index].data['y'],
                                    //   videoUrl:
                                    //       snapshot.data[index].data['yy'],
                                    // ),
                                    // HomeRow(
                                    //   imageUrl:
                                    //       snapshot.data[index].data['z'],
                                    //   videoUrl:
                                    //       snapshot.data[index].data['zz'],
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              );
            }
          },
        ),
      ),
    ); //!
  }
}

class HomeRow2 extends StatelessWidget {
  const HomeRow2({Key key, @required this.imageUrl, this.ontap})
      : super(key: key);
  final String imageUrl;

  final Function ontap;
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);

    final double itemWidth = scaler.getWidth(10);
    return HomeRowDpad(
      onTap: ontap,
      child: Container(
        width: itemWidth,
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) => Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              width: itemWidth,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation<Color>(Colors.redAccent[700]),
            ),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}

class HomeRow extends StatelessWidget {
  const HomeRow({Key key, @required this.imageUrl, this.ontap})
      : super(key: key);
  final String imageUrl;

  final Function ontap;

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    final double itemWidth = scaler.getWidth(20);
    return Container(
      width: itemWidth,
      child: InkWell(
        onTap: ontap,
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: imageUrl,
          imageBuilder: (context, imageProvider) => Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              width: MediaQuery.of(context).size.width -
                  MediaQuery.of(context).size.width * 0.75,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation<Color>(Colors.redAccent[700]),
            ),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
