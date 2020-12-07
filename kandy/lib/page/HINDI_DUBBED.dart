import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kandy/details/tvdetails.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:kandy/homescreen/button_dpad.dart';
import 'package:kandy/player/internal_videoplayer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:optimized_cached_image/image_cache_manager.dart';
import 'package:optimized_cached_image/widgets.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class HINDI_DUBBED extends StatefulWidget {
  HINDI_DUBBED({Key key}) : super(key: key);

  @override
  _HINDI_DUBBEDState createState() => _HINDI_DUBBEDState();
}

class _HINDI_DUBBEDState extends State<HINDI_DUBBED> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: HINDI_DUBBEDpage(),
    );
  }
}

class HINDI_DUBBEDpage extends StatefulWidget {
  HINDI_DUBBEDpage({Key key}) : super(key: key);

  @override
  _HINDI_DUBBEDpageState createState() => _HINDI_DUBBEDpageState();
}

class _HINDI_DUBBEDpageState extends State<HINDI_DUBBEDpage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  Future _data;
  Future getHINDI_DUBBED() async {
    var firestore = Firestore.instance;
    QuerySnapshot gh =
        await firestore.collection('HINDI_DUBBED').getDocuments();
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

  @override
  void initState() {
    super.initState();
    initUser();
    ImageCacheManager.init(ImageCacheConfig(
        widthKey: "custom-width",
        heightKey: "custom-height",
        storagePath: path(),
        enableLog: !kReleaseMode));
    _data = getHINDI_DUBBED();
  }

  Future<Directory> path() async => (await getExternalCacheDirectories())[0];

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    final double itemHeight = scaler.getHeight(100);
    final double itemWidth = scaler.getWidth(40);
    final double itemPotraitHeight = scaler.getHeight(20);
    final double itemPotraitWidth = scaler.getWidth(24);
    return Container(
      child: Container(
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
              return Scaffold(
                resizeToAvoidBottomPadding: false,
                backgroundColor: Colors.black,
                body: new OrientationBuilder(builder: (context, orientation) {
                  return GridView.builder(
                      controller: new ScrollController(keepScrollOffset: false),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            orientation == Orientation.landscape ? 9 : 4,
                        childAspectRatio: orientation == Orientation.landscape
                            ? (itemWidth / itemHeight)
                            : (itemPotraitWidth / itemPotraitHeight),
                      ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return new Container(
                          padding: scaler.getPaddingLTRB(0.5, 0, 0.5, 0),
                          color: Colors.black,
                          margin: scaler.getMarginLTRB(0, 0, 0, 0),
                          child: new Center(
                            child: ButtonDpad(
                              onTap: () {
                                navigatetoplayerdetails(
                                            snapshot.data[index].data['aa']);
                              },
                              child: OptimizedCacheImage(
                                height: orientation == Orientation.landscape
                                    ? scaler.getHeight(10.4)
                                    : itemPotraitHeight,
                                width: orientation == Orientation.landscape
                                    ? scaler.getWidth(13.2)
                                    : itemPotraitWidth,
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
                      });
                }),
              );
            }
          },
        ),
      ),
    );
  }
}
