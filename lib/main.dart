import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'Hello'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _total = 0;
  double _size = 100.0;

  void _incrementCounter() {
    setState(() {
      _total++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Draggable(
              data: 1,
              child: draggableBox(
                  color: Colors.blue,
                  radius: 10.0,
                  size: _size,
                  text: 1.toString()),
              feedback: draggableBox(
                  color: Colors.blue,
                  radius: 20.0,
                  size: _size,
                  text: 1.toString()),
              childWhenDragging: draggableBox(
                  color: Colors.grey[300],
                  radius: 20.0,
                  size: _size,
                  text: 1.toString()),
            ),
            DragTarget<int>(
              onWillAccept: (value) => value == 1,
              onAccept: (value) => _incrementCounter(),
              onLeave: (value) => setState(() {
                _total += 10;
              }),
              builder: (context, candidates, rejects) {
                return draggableBox(
                    color: _total > 0 ? Colors.blue : Colors.grey[300],
                    radius: _total > 0 ? 20.0 : 10.0,
                    size: _size,
                    text: _total.toString());
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: FlatButton.icon(
                onPressed: () => setState(() {
                  _total = 0;
                }),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
                label: Text('Refresh', style: TextStyle(color: Colors.white)),
                color: Colors.orange,
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget draggableBox(
      {Color color, double size, double radius, String text = ''}) {
    return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),
          ),
        ));
  }
}
