import 'package:flutter/material.dart';
import 'package:kandy/homescreen/button_dpad.dart';

class Logout extends StatelessWidget {
  const Logout({Key key, this.userIds, this.button}) : super(key: key);
  final Widget userIds;
  final dynamic button;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.black,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                maxRadius: 50,
                minRadius: 50,
                backgroundColor: Colors.blue,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: userIds,
                // Text(
                //   "USER: ${user?.email}",
                //   style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold),
                // ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: LogoutDpad(
                  onTap: button,
                  child: FloatingActionButton.extended(
                      backgroundColor: Colors.redAccent[700],
                      onPressed: button,
                      icon: Icon(
                        Icons.power_settings_new,
                        color: Colors.white,
                        size: 30,
                      ),
                      label: Text(
                        'Logout..',
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      )),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    " @ app Created By: \n\n TAPOS & GOUTAM ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class Logoutp extends StatelessWidget {
  const Logoutp({Key key, this.userIds, this.button}) : super(key: key);
  final Widget userIds;
  final dynamic button;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.black,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                maxRadius: 50,
                minRadius: 50,
                backgroundColor: Colors.blue,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: userIds,
                // Text(
                //   "USER: ${user?.email}",
                //   style: TextStyle(
                //       color: Colors.white,
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold),
                // ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: FloatingActionButton.extended(
                    backgroundColor: Colors.redAccent[700],
                    onPressed: button,
                    icon: Icon(
                      Icons.power_settings_new,
                      color: Colors.white,
                      size: 30,
                    ),
                    label: Text(
                      'Logout..',
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    )),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Text(
                    " @ app Created By: \n\n TAPOS & GOUTAM ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
