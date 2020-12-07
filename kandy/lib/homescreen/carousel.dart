import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';
import 'package:kandy/homescreen/button_dpad.dart';
import 'package:kandy/player/internal_videoplayer.dart';
import 'package:optimized_cached_image/image_cache_manager.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';


class POSTER extends StatefulWidget {
  POSTER({Key key}) : super(key: key);

  @override
  _POSTERState createState() => _POSTERState();
}

class _POSTERState extends State<POSTER> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: POSTERpage(),
    );
  }
}

class POSTERpage extends StatefulWidget {
  POSTERpage({Key key}) : super(key: key);

  @override
  _POSTERpageState createState() => _POSTERpageState();
}

class _POSTERpageState extends State<POSTERpage> {
  Future _data;
  Future getPOSTER() async {
    var firestore = Firestore.instance;
    QuerySnapshot gh = await firestore.collection('POSTER').getDocuments();
    return gh.documents;
  }

  navigatetoplayerdetails(String url) {
    String result = url.replaceAll("vlc://", "");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InternalVideoplayerPage(url: result)));
  }

  @override
  void initState() {
    super.initState();
    ImageCacheManager.init(
        ImageCacheConfig(storagePath: path(), enableLog: !kReleaseMode));
    _data = getPOSTER();
  }

  Future<Directory> path() async => (await getExternalCacheDirectories())[0];
  @override
  Widget build(BuildContext context) {
    CarouselController cc;
    return Container(
      child: Container(
        child: FutureBuilder(
          future: _data,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Scaffold(
                  backgroundColor: Colors.black,
                  body: Center(
                      child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Colors.redAccent[700]),
                  )));
            else {
              return Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: CarouselSlider.builder(
                    carouselController: cc,
                    options: CarouselOptions(
                      autoPlayAnimationDuration: Duration(microseconds: 600),
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      enableInfiniteScroll: true,
                    ),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        child: InkWell(
                          onTap: () {
                            navigatetoplayerdetails(
                                snapshot.data[index].data['aa']);
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: OptimizedCacheImage(
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.redAccent[700]),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              imageUrl: snapshot.data[index].data["a"],
                            ),
                          ),
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

class POSTER2 extends StatefulWidget {
  POSTER2({Key key}) : super(key: key);

  @override
  _POSTER2State createState() => _POSTER2State();
}

class _POSTER2State extends State<POSTER2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: POSTER2page(),
    );
  }
}

class POSTER2page extends StatefulWidget {
  POSTER2page({Key key}) : super(key: key);

  @override
  _POSTER2pageState createState() => _POSTER2pageState();
}

class _POSTER2pageState extends State<POSTER2page> {
  Future _data;
  Future getPOSTER() async {
    var firestore = Firestore.instance;
    QuerySnapshot gh = await firestore.collection('POSTER').getDocuments();
    return gh.documents;
  }

  navigatetoplayerdetails(String url) {
    String result = url.replaceAll("vlc://", "");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => InternalVideoplayerPage(url: result)));
  }

  @override
  void initState() {
    super.initState();
    ImageCacheManager.init(
        ImageCacheConfig(storagePath: path(), enableLog: !kReleaseMode));
    _data = getPOSTER();
  }

  Future<Directory> path() async => (await getExternalCacheDirectories())[0];
  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    final double itemHeight = scaler.getHeight(100);
    final double itemWidth = scaler.getWidth(100);
    CarouselController cc;
    return Container(
      child: Container(
        child: FutureBuilder(
          future: _data,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Scaffold(
                  backgroundColor: Colors.black,
                  body: Center(
                      child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(
                        Colors.redAccent[700]),
                  )));
            else {
              return Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: CarouselSlider.builder(
                    carouselController: cc,
                    options: CarouselOptions(
                      autoPlayAnimationDuration: Duration(microseconds: 3000),
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      enableInfiniteScroll: true,
                    ),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: itemWidth,
                        child: HomecarroselDpad(
                          onTap: () {
                            navigatetoplayerdetails(
                                snapshot.data[index].data['aa']);
                          },
                          child: Container(
                            width: itemWidth,
                            color: Colors.transparent,
                            child: OptimizedCacheImage(
                              height: scaler.getHeight(26),
                              width: scaler.getWidth(79),
                              fit: BoxFit.fill,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.redAccent[700]),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              imageUrl: snapshot.data[index].data["a"],
                            ),
                          ),
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
