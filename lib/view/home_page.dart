import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';
import 'package:flutter_beacon_listen/components/beacon_item.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isListening = false;
  final regions = <Region>[];
  StreamSubscription? beaconStream;
  List<Beacon> beacons = [];

  @override
  void initState() {
    super.initState();
    _initFlutterBeacon();
  }

  @override
  void dispose() {
    beaconStream?.cancel();
    super.dispose();
  }

  void _initFlutterBeacon() async {
    try {
      await flutterBeacon.initializeScanning;
      await flutterBeacon.initializeAndCheckScanning; // 권한체크=>자동권한요청

      if (Platform.isIOS) {
        regions.add(Region(
          identifier: 'Test',
          proximityUUID: '39ED98FF-2900-441A-802F-9C398FC199D2', // 수신할 UUID
        ));
      } else {
        regions.add(Region(identifier: 'Test')); // Android는 모든 Beacon 수신 가능
      }

      print(
          '\x1B[95m========== Flutter Beacon Initialized ==========\x1B[105m');
    } on PlatformException catch (e) {
      print('\x1B[95m========== Flutter Beacon Init Faild ==========\x1B[105m');
    }
  }

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
                if (_isListening) {
                  beaconStream!.pause(); // 리스닝 일시정지
                  beacons = [];
                } else {
                  // 스크림구독이 초기화 됐으면 재시작 하고, 널이면
                  beaconStream == null
                      ? beaconStream =
                          flutterBeacon.ranging(regions).listen((r) {
                          beacons = r.beacons;
                          setState(() {});
                        })
                      : beaconStream!.resume();
                }
                _isListening = !_isListening;
                setState(() {});
              },
              child: _isListening ? Text("비콘수신 중지!") : Text("비콘수신 시작!"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: beacons.length,
                itemBuilder: (context, index) {
                  Beacon beacon = beacons[index];
                  return BeaconItem(
                    uuid: beacon.proximityUUID,
                    majorId: beacon.major,
                    minorId: beacon.minor,
                    accuracy: beacon.accuracy,
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
