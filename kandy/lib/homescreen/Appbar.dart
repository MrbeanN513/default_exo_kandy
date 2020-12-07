import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kandy/TV/tvshow.dart';
import 'package:kandy/homescreen/button_dpad.dart';

class CustomAppBar extends PreferredSize {
  final double height;

  CustomAppBar({this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return landscapeAppbar(context);
  }
}

class CustomAppBarp extends PreferredSize {
  final double height;

  CustomAppBarp({this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return portaitAppbar(context);
  }
}

class CustomDialouge extends StatefulWidget {
  CustomDialouge({Key key}) : super(key: key);

  @override
  _CustomDialougeState createState() => _CustomDialougeState();
}

class _CustomDialougeState extends State<CustomDialouge> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        height: 150.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "USER NAME:${user?.email}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  AppdialougeDpad(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: RaisedButton(
                      color: Colors.blue,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'BACK',
                        style: TextStyle(fontSize: 12.0, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  AppdialougeDpad(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: RaisedButton(
                      color: Colors.redAccent[700],
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'CANCEL',
                        style: TextStyle(fontSize: 12.0, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDialougep extends StatefulWidget {
  CustomDialougep({Key key}) : super(key: key);

  @override
  _CustomDialougepState createState() => _CustomDialougepState();
}

class _CustomDialougepState extends State<CustomDialougep> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        height: 150.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "USER NAME:${user?.email}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'BACK',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RaisedButton(
                    color: Colors.redAccent[700],
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'CANCEL!',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget landscapeAppbar(context) {
  return AppBar(
    leading: AppBarDpad(
      onTap: () {},
      child: Icon(
        Icons.menu,
        color: Colors.white,
        size: 25,
      ),
    ),
    actions: <Widget>[
      AppBarDpad(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Tvshow()),
          );
        },
        child: Icon(
          Icons.tv,
          size: 25,
          color: Colors.white,
        ),
      ),
      AppBarDpad(
        onTap: null,
        child: Icon(
          Icons.search,
          size: 25,
          color: Colors.white,
        ),
      ),
      AppBarDpad(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => CustomDialouge(),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Container(
              width: 40.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('images/pro_pic.png')))),
        ),
      ),
    ],
    centerTitle: true,
    title:
        SizedBox(height: 50.0, child: Image.asset('images/Netflix-logo.png')),
    backgroundColor: Colors.black,
  );
}

Widget portaitAppbar(context) {
  return AppBar(
    leading: IconButton(
      icon: Icon(
        Icons.menu,
        color: Colors.white,
        size: 25,
      ),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(
          Icons.tv,
          color: Colors.white,
          size: 25,
        ),
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(
          Icons.search,
          color: Colors.white,
          size: 25,
        ),
        onPressed: () {},
      ),
      InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => CustomDialougep(),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Container(
              width: 40.0,
              decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('images/pro_pic.png')))),
        ),
      ),
    ],
    centerTitle: true,
    title:
        SizedBox(height: 50.0, child: Image.asset('images/Netflix-logo.png')),
    backgroundColor: Colors.black,
  );
}
