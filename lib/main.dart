import 'dart:async';

import 'package:flutter/material.dart';
import 'circular_progress_button.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circular Progress Button Example',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: TextTheme(
          button: TextStyle(
            color: Colors.white
          )
        )
      ),
      home: MyHomePage(title: 'Circular Progress Button Example'),
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
  
  Future<Null> _onAnimationComplete() async {
    await Future.delayed(Duration(seconds: 2));
    
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => SecondPage())
    );

    return null;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: CircularProgressButton(
          text: "Login",
          onAnimationComplete: _onAnimationComplete 
        )
      )
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second page")
      ),
      body: Center(
        child: Text(
          "Second Page",
          style: TextStyle(
            fontSize: 20.0
          )
        ) 
      )
    );
  }
}
