import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Container(
              width: 90,
              child: Column(
                children: [
                  Container(
                    width: 90,
                    child: Row(
                      children: [
                        Container(
                          width: 30,
                          child: Column(
                            children: [
                              Box(
                                Colors.grey,
                                height: 30,
                                width: 30,
                              ),
                              Box(
                                Colors.orange,
                                height: 30,
                                width: 30,
                              ),
                              Box(
                                Colors.blue,
                                height: 30,
                                width: 30,
                              ),
                              Box(
                                Colors.pink[300],
                                height: 30,
                                width: 30,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 60,
                          child: Column(
                            children: [
                              Box(
                                Colors.blue[400],
                                height: 90,
                                width: 60,
                              ),
                              Row(
                                children: [
                                  Box(
                                    Colors.green,
                                    height: 30,
                                    width: 30,
                                  ),
                                  Box(
                                    Colors.yellow,
                                    height: 30,
                                    width: 30,
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Box(Colors.black),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Box(Colors.yellow),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Box(Colors.white),
                  ),
                ],
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: Box(Colors.pink[400]),
            ),
            Box(
              Colors.white,
              width: 15,
            ),
            Flexible(
              fit: FlexFit.tight,
              flex: 1,
              child: Box(Colors.pink[400]),
            ),
          ],
        ),
        Positioned(
          child: FloatingActionButton(
            child: Icon(Icons.play_arrow),
            backgroundColor: Colors.blue,
          ),
          bottom: 20,
          right: 20,
        ),
        Positioned(
          child: Box(
            Colors.black38,
            height: 150,
            width: 150,
          ),
          bottom: 200,
          left: 60,
        )
      ],
    );
  }
}

class Box extends StatelessWidget {
  Color color;
  double height;
  double width;

  Box(Color color, {double height, double width}) {
    this.color = color;
    this.height = height;
    this.width = width;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.height,
      width: this.width,
      decoration: BoxDecoration(
        color: this.color,
      ),
    );
  }
}
