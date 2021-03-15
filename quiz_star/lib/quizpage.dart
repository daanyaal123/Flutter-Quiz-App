import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz_star/resultpage.dart';

// ignore: camel_case_types
//ignore: must_be_immutable
class loadjson extends StatelessWidget {
  String langname;
  loadjson(this.langname);
  String assettoload;

  setasset() {
    if (langname == "Python") {
      assettoload = "assets/json/python.json";
    } else if (langname == "Java") {
      assettoload = "assets/json/java.json";
    } else if (langname == "Javascript") {
      assettoload = "assets/json/js.json";
    } else if (langname == "C++") {
      assettoload = "assets/json/cpp.json";
    } else {
      assettoload = "assets/linux.json";
    }
  }

  @override
  Widget build(BuildContext context) {
    setasset();
    // and now we return the FutureBuilder to load and decode JSON
    return FutureBuilder(
      future:
          DefaultAssetBundle.of(context).loadString(assettoload, cache: false),
      builder: (context, snapshot) {
        List mydata = json.decode(snapshot.data.toString());
        if (mydata == null) {
          return Scaffold(
            body: Center(
              child: Text(
                "Loading",
              ),
            ),
          );
        } else {
          return quizpage(mydata: mydata);
        }
      },
    );
  }
}

// ignore: camel_case_types
class quizpage extends StatefulWidget {
  final List mydata;

  quizpage({Key key, @required this.mydata}) : super(key: key);
  @override
  _quizpageState createState() => _quizpageState(mydata: mydata);
}

// ignore: camel_case_types
class _quizpageState extends State<quizpage> {
  List mydata;
  _quizpageState({this.mydata});
  int i = 1;
  int marks = 0;
  Color right = Colors.green;
  Color colortoshow = Colors.cyanAccent;
  Color wrong = Colors.red;
  int timer = 30;
  bool canceltimer = false;
  String showtimer = "30";

  Map<String, Color> btncolor = {
    "a": Colors.cyanAccent,
    "b": Colors.cyanAccent,
    "c": Colors.cyanAccent,
    "d": Colors.cyanAccent,
  };

  void nextquestion() {
    canceltimer = false;
    timer = 30;
    setState(() {
      if (i < 10) {
        i++;
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => resultpage(marks: marks),
        ));
      }
      btncolor["a"] = Colors.cyanAccent;
      btncolor["b"] = Colors.cyanAccent;
      btncolor["c"] = Colors.cyanAccent;
      btncolor["d"] = Colors.cyanAccent;
    });
    starttimer();
  }

  @override
  void initState() {
    starttimer();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void starttimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          nextquestion();
        } else if (canceltimer == true) {
          t.cancel();
        } else {
          timer = timer - 1;
        }
        showtimer = timer.toString();
      });
    });
  }

  void checkanswer(String k) {
    if (mydata[2][i.toString()] == mydata[1][i.toString()][k]) {
      // answer is correct
      marks = marks + 5;
      colortoshow = right;
    } else {
      colortoshow = wrong;
    }
    setState(() {
      canceltimer = true;
      btncolor[k] = colortoshow;
      Timer(Duration(seconds: 2), nextquestion);
    });
  }

  Widget choicebutton(String k) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: () => checkanswer(k),
        child: Text(
          mydata[1][i.toString()][k],
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
          maxLines: 3,
        ),
        color: btncolor[k],
        splashColor: Colors.cyan[700],
        highlightColor: Colors.indigo[700],
        minWidth: 200.0,
        height: 45.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "Quizstar",
            ),
            content: Text(
              "You Can't Go Back At This Stage",
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "OK",
                ),
              )
            ],
          ),
        );
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 40.0,
                  horizontal: 20.0,
                ),
                alignment: Alignment.bottomLeft,
                child: Text(
                  mydata[0][i.toString()],
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    choicebutton("a"),
                    choicebutton("b"),
                    choicebutton("c"),
                    choicebutton("d"),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  showtimer,
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w700,
                    fontFamily: "Times New Roman",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
