import 'package:flutter/material.dart';
import 'package:flutter_beacon_listen/components/beacon_item.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isListening = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        title: Text("Flutter Beacon Listen App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _isListening = !_isListening;
                setState(() {});
              },
              child: _isListening ? Text("비콘수신 중지!") : Text("비콘수신 시작!"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return BeaconItem(
                    uuid: "9dba0f8c-5ac5-4cc5-8aa3-032d1d2c1de3",
                    majorId: 1,
                    minorId: 100,
                    accuracy: 0.2,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
