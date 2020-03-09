import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

class DemoScreen extends StatefulWidget {
  DemoScreen({Key key}) : super(key: key);

  @override
  _DemoScreenState createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  AudioCache _player = AudioCache();
  Timer _timer;
  TextEditingController _controller = TextEditingController();
  final String _rightSound = "right.amr";
  final String _wrongSound = "wrong.amr";

  _DemoScreenState() {
    _player.load(_rightSound);
    _player.load(_wrongSound);
  }

  void playASound() {
    var rng = Random();

    if (rng.nextInt(100) < 49) {
      _player.play(_rightSound);
    } else {
      _player.play(_wrongSound);
    }

    Future.delayed(Duration(milliseconds: 500), () {
      _controller.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Scanner Demo App",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Container(
            width: 300,
            child: TextField(
              controller: _controller,
              onChanged: (text) {
                if (text.length == 1)
                  _timer = Timer(Duration(milliseconds: 50), playASound);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Colors.black,
                    style: BorderStyle.solid,
                    width: 4.0,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    _player.play(_rightSound);
                  },
                  color: Colors.green,
                  child: Text("Succesful"),
                ),
                RaisedButton(
                  onPressed: () {
                    _player.play(_wrongSound);
                  },
                  color: Colors.red,
                  child: Text("Failure"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
