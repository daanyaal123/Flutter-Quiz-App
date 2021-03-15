import 'package:flutter/material.dart';
import 'package:quiz_star/quizpage.dart';

// ignore: camel_case_types
class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

// ignore: camel_case_types
class _homepageState extends State<homepage> {
  List<String> language = ["Python", "Java", "Script", "C++", "Linux"];

  List<String> images = [
    "assets/images/py.png",
    "assets/images/java.png",
    "assets/images/script.png",
    "assets/images/cpp.png",
    "assets/images/linux.png"
  ];

  List<String> des = [
    "Python is an interpreted, high-level and general-purpose programming language.",
    "Java is a class-based, object-oriented programming language that is designed to have as few implementation dependencies as possible.",
    "JavaScript is a lightweight, interpreted programming language. It is designed for creating network-centric applications.",
    "C++ is a powerful general-purpose programming language. It can be used to develop operating systems, browsers, games, and so on.",
    "A Linux-based system is a modular Unix-like operating system, deriving much of its basic design from principles established in Unix during the 1970s and 1980s."
  ];

  Widget customcard(String langname, String des, String img) {
    return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 30.0,
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => loadjson(langname),
                ));
          },
          child: Material(
            borderRadius: BorderRadius.circular(40.0),
            elevation: 10.0,
            color: Colors.blue,
            child: Container(
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Container(
                        width: 150.0,
                        height: 150.0,
                        child: ClipOval(
                          child: Image(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              img,
                            ),
                          ),
                        ),
                      )),
                  Center(
                    child: Text(
                      langname,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      bottom: 15.0,
                      top: 5.0,
                      right: 10.0,
                      left: 10.0,
                    ),
                    child: Text(
                      des,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.justify,
                      maxLines: 8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quiz Star",
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          customcard(language[0], des[0], images[0]),
          customcard(language[1], des[1], images[1]),
          customcard(language[2], des[2], images[2]),
          customcard(language[3], des[3], images[3]),
          //customcard(language[4], des[4], images[4]),
        ],
      ),
    );
  }
}
