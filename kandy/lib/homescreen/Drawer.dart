import 'package:flutter/material.dart';

class Drawers extends StatelessWidget {
  const Drawers({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          home: Container(
        child: Column(
          children: [
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/BANGLA');
                },
                child: Text(
                  "jhfhgdsfjhgfjs",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
