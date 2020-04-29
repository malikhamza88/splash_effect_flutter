import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:splasheffect/splash.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Splash(
                        onTap: () {},
                        child: RaisedButton(
                          child: Text(
                            "Hye! I am RaisedButton",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: null,
                          disabledColor: Colors.deepOrange,
                        ),
                      ),
                      Splash(
                        child: Text("I am Text"),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                Splash(
                  onTap: () {},
                  child: Container(
                    height: 200,
                    width: 500,
                    color: Colors.teal,
                    child: Center(
                      child: Text(
                        "Hye! I am container. Tap on me and check the splash effect. You will notice the bigger size effect according to my size.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                  ),
                ),
                Splash(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(
                        Icons.code,
                        size: 70,
                      ),
                      Column(
                        children: <Widget>[
                          Text("Disabled Radio Button"),
                          Splash(
                            onTap: () {},
                            child: Radio(
                              value: false,
                              groupValue: null,
                              onChanged: null,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
