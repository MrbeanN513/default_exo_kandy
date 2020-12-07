import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class InternalVideoplayerPage extends StatefulWidget {
  final String url;

  InternalVideoplayerPage({
    this.url,
  });

  @override
  _InternalVideoplayerPageState createState() =>
      _InternalVideoplayerPageState();
}

class _InternalVideoplayerPageState extends State<InternalVideoplayerPage> {
  BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    String videoUrl = widget.url;
    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
      rotation: 0,
      fullScreenByDefault: true,
      allowedScreenSleep: false,
      autoPlay: true,
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
    );

    BetterPlayerDataSource dataSource =
        BetterPlayerDataSource(BetterPlayerDataSourceType.NETWORK, videoUrl);
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    super.initState();
  }

  @override
  void dispose() {
    print("dispose was called");
    _betterPlayerController.pause();
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    final double itemHeight = scaler.getHeight(10);
    final double itemWidth = scaler.getWidth(30);
    final double itemPotraitHeight = scaler.getHeight(5);
    // final double itemPotraitWidth = scaler.getWidth(24);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    return new OrientationBuilder(builder: (context, orientation) {
      return WillPopScope(
        onWillPop: () async => showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  backgroundColor: Colors.black87.withAlpha(150),
                  title: Text(
                    'Are you Leaving....?',
                    style: TextStyle(color: Colors.white),
                  ),
                  content: Container(
                    width: itemWidth,
                    color: Colors.transparent,
                    height: orientation == Orientation.landscape
                        ? itemHeight
                        : itemPotraitHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ExitDpad(
                            onTap: () {
                              Navigator.of(context).pop(true);
                              setState(() {
                                _betterPlayerController.pause();
                              });
                            },
                            child: RaisedButton(
                                color: Colors.transparent,
                                child: Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop(true);

                                  setState(() {
                                    _betterPlayerController.pause();
                                  });
                                }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ExitDpad(
                            onTap: () {
                              Navigator.of(context).pop(false);
                            },
                            child: RaisedButton(
                                color: Colors.transparent,
                                child: Text(
                                  'cancel',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () =>
                                    Navigator.of(context).pop(false)),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
        child: Container(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: BetterPlayer(controller: _betterPlayerController),
          ),
        ),
      );
    });
  }
}
