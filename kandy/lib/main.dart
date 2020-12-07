import 'package:bottom_navy_bar/sidebar_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:kandy/homescreen/Appbar.dart';
import 'package:kandy/login/services/authentication.dart';
import 'package:kandy/page/BANGLA.dart';
import 'package:kandy/page/BOLLYWOOD.dart';
import 'package:kandy/page/ENGLISH.dart';
import 'package:kandy/page/HINDI_DUBBED.dart';
import 'package:bottom_navy_bar/sidebar.dart';
import 'package:kandy/page/HOMEPAGE.dart';
import 'package:kandy/page/SOUTH.dart';
import 'homescreen/splashscreen.dart';
import 'login/logout.dart';
import 'login/pages/root_page.dart';
import 'login/services/authentication.dart';
import 'package:connectivity_widget/connectivity_widget.dart';
import 'notification/notification.dart';

void main() => runApp(Akdom1st());

class Akdom1st extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);

    return Shortcuts(
      // needed for AndroidTV to be able to select
      shortcuts: {
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
      },
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: new SplashScreen(),
          routes: <String, WidgetBuilder>{
            '/RootPage': (BuildContext context) =>
                new RootPage(auth: new Auth()),
          }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.auth, this.userId, this.logoutCallback, this.title})
      : super(key: key);

  final String title;
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    initUser();
    _pageController = PageController();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ConnectivityUtils.initialize(
        serverToPing:
            "https://gist.githubusercontent.com/Vanethos/dccc4b4605fc5c5aa4b9153dacc7391c/raw/355ccc0e06d0f84fdbdc83f5b8106065539d9781/gistfile1.txt",
        callback: (response) => response.contains("This is a test!"));
    return new OrientationBuilder(builder: (context, orientation) {
      return Scaffold(
          resizeToAvoidBottomPadding: false,
          body: ConnectivityWidget(
            // onlineCallback: _incrementCounter,
            builder: (context, isOnline) => SizedBox.expand(
              child: orientation == Orientation.landscape
                  ? Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: SideBarr(
                            itemCornerRadius: 10,
                            width: 30,
                            height: double.maxFinite,
                            showElevation: true,
                            iconSize: 12.0,
                            backgroundColor: Colors.black,
                            containerHeight: 20.0,
                            selectedIndex: _currentIndex,
                            onItemSelected: (index) {
                              setState(() => _currentIndex = index);
                              _pageController.jumpToPage(index);
                            },
                            items: <SideBarrItem>[
                              SideBarrItem(
                                  activeColor: Colors.redAccent[700],
                                  inactiveColor: Colors.grey,
                                  title: Text(
                                    'Home',
                                    style: TextStyle(fontSize: 9),
                                  ),
                                  icon: Icon(Icons.home)),
                              SideBarrItem(
                                  activeColor: Colors.redAccent[700],
                                  inactiveColor: Colors.grey,
                                  title: Text(
                                    'DUBBED',
                                    style: TextStyle(fontSize: 9),
                                  ),
                                  icon: Icon(Icons.local_movies)),
                              SideBarrItem(
                                  activeColor: Colors.redAccent[700],
                                  inactiveColor: Colors.grey,
                                  title: Text(
                                    'ENGLISH',
                                    style: TextStyle(fontSize: 9),
                                  ),
                                  icon: Icon(Icons.movie)),
                              SideBarrItem(
                                  activeColor: Colors.redAccent[700],
                                  inactiveColor: Colors.grey,
                                  title: Text(
                                    'BOLLYWOOD',
                                    style: TextStyle(fontSize: 7),
                                  ),
                                  icon: Icon(Icons.movie_filter)),
                              SideBarrItem(
                                  activeColor: Colors.redAccent[700],
                                  inactiveColor: Colors.grey,
                                  title: Text(
                                    'SOUTH',
                                    style: TextStyle(fontSize: 9),
                                  ),
                                  icon: Icon(Icons.ondemand_video)),
                              SideBarrItem(
                                  activeColor: Colors.redAccent[700],
                                  inactiveColor: Colors.grey,
                                  title: Text(
                                    'BANGLA',
                                    style: TextStyle(fontSize: 9),
                                  ),
                                  icon: Icon(Icons.video_label)),
                              SideBarrItem(
                                  activeColor: Colors.redAccent[700],
                                  inactiveColor: Colors.grey,
                                  title: Text(
                                    'LOGOUT',
                                    style: TextStyle(fontSize: 9),
                                  ),
                                  icon: Icon(Icons.power_settings_new)),
                              SideBarrItem(
                                  activeColor: Colors.redAccent[700],
                                  inactiveColor: Colors.grey,
                                  title: Text(
                                    'NOTIFY',
                                    style: TextStyle(fontSize: 9),
                                  ),
                                  icon: Icon(Icons.notifications)),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 9,
                          child: PageView(
                            controller: _pageController,
                            onPageChanged: (index) {
                              setState(() => _currentIndex = index);
                            },
                            children: <Widget>[
                              Homepage(),
                              HINDI_DUBBED(),
                              ENGLISH(),
                              BOLLYWOOD(),
                              SOUTH(),
                              BANGLA(),
                              Logout(
                                button: signOut,
                                userIds: Text(
                                  "USER: ${user?.email}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Notificationss(),
                            ],
                          ),
                        ),
                      ],
                    )
                  //!potrait
                  : PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() => _currentIndex = index);
                      },
                      children: <Widget>[
                        Homepagep(),
                        HINDI_DUBBED(),
                        ENGLISH(),
                        BOLLYWOOD(),
                        SOUTH(),
                        BANGLA(),
                        Logoutp(
                          button: signOut,
                          userIds: Text(
                            "USER: ${user?.email}",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Notificationss(),
                      ],
                    ),
            ),
          ),
          appBar: orientation == Orientation.landscape
              ? CustomAppBar()
              : CustomAppBarp(),
          drawerEnableOpenDragGesture:
              orientation == Orientation.landscape ? false : true,
          drawer: SideBarrDrawer(
            height: double.maxFinite,
            showElevation: true,
            iconSize: 25.0,
            backgroundColor: Colors.black,
            containerHeight: 56.0,
            selectedIndex: _currentIndex,
            onItemSelected: (index) {
              setState(() => _currentIndex = index);
              _pageController.jumpToPage(index);
            },
            items: <SideBarrDrawerItem>[
              SideBarrDrawerItem(
                  activeColor: Colors.redAccent[700],
                  inactiveColor: Colors.grey,
                  title: Text('Home'),
                  icon: Icon(Icons.home)),
              SideBarrDrawerItem(
                  activeColor: Colors.redAccent[700],
                  inactiveColor: Colors.grey,
                  title: Text('DUBBED'),
                  icon: Icon(Icons.local_movies)),
              SideBarrDrawerItem(
                  activeColor: Colors.redAccent[700],
                  inactiveColor: Colors.grey,
                  title: Text('ENGLISH'),
                  icon: Icon(Icons.movie)),
              SideBarrDrawerItem(
                  activeColor: Colors.redAccent[700],
                  inactiveColor: Colors.grey,
                  title: Text('BOLLYWOOD'),
                  icon: Icon(Icons.movie_filter)),
              SideBarrDrawerItem(
                  activeColor: Colors.redAccent[700],
                  inactiveColor: Colors.grey,
                  title: Text('SOUTH'),
                  icon: Icon(Icons.ondemand_video)),
              SideBarrDrawerItem(
                  activeColor: Colors.redAccent[700],
                  inactiveColor: Colors.grey,
                  title: Text('BANGLA'),
                  icon: Icon(Icons.video_label)),
              SideBarrDrawerItem(
                  activeColor: Colors.redAccent[700],
                  inactiveColor: Colors.grey,
                  title: Text('logout'),
                  icon: Icon(Icons.power_settings_new)),
              SideBarrDrawerItem(
                  activeColor: Colors.redAccent[700],
                  inactiveColor: Colors.grey,
                  title: Text(
                    'NOTIFY',
                    style: TextStyle(fontSize: 12),
                  ),
                  icon: Icon(Icons.notifications)),
            ],
          ),
          bottomNavigationBar: orientation == Orientation.landscape
              ? Container(
                  height: 0.0,
                  width: 0.0,
                )
              : BottomNavyBar(
                  showElevation: true,
                  iconSize: 25.0,
                  backgroundColor: Colors.black,
                  containerHeight: 50.0,
                  selectedIndex: _currentIndex,
                  onItemSelected: (index) {
                    setState(() => _currentIndex = index);
                    _pageController.jumpToPage(index);
                  },
                  items: <BottomNavyBarItem>[
                    BottomNavyBarItem(
                        activeColor: Colors.redAccent[700],
                        inactiveColor: Colors.grey,
                        title: Text('Home'),
                        icon: Icon(Icons.home)),
                    BottomNavyBarItem(
                        activeColor: Colors.redAccent[700],
                        inactiveColor: Colors.grey,
                        title: Text('DUBBED'),
                        icon: Icon(Icons.local_movies)),
                    BottomNavyBarItem(
                        activeColor: Colors.redAccent[700],
                        inactiveColor: Colors.grey,
                        title: Text('ENGLISH'),
                        icon: Icon(Icons.movie)),
                    BottomNavyBarItem(
                        activeColor: Colors.redAccent[700],
                        inactiveColor: Colors.grey,
                        title: Text('BOLLYWOOD'),
                        icon: Icon(Icons.movie_filter)),
                    BottomNavyBarItem(
                        activeColor: Colors.redAccent[700],
                        inactiveColor: Colors.grey,
                        title: Text('SOUTH'),
                        icon: Icon(Icons.ondemand_video)),
                    BottomNavyBarItem(
                        activeColor: Colors.redAccent[700],
                        inactiveColor: Colors.grey,
                        title: Text('BANGLA'),
                        icon: Icon(Icons.video_label)),
                    BottomNavyBarItem(
                        activeColor: Colors.redAccent[700],
                        inactiveColor: Colors.grey,
                        title: Text('logout'),
                        icon: Icon(Icons.power_settings_new)),
                  ],
                ));
    });
  }
}
