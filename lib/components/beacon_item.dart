import 'package:flutter/material.dart';

class BeaconItem extends StatelessWidget {
  String uuid;
  int majorId;
  int minorId;
  double accuracy;

  BeaconItem({
    Key? key,
    required this.uuid,
    required this.majorId,
    required this.minorId,
    required this.accuracy,
  }) : super(key: key);

  Widget _label(String txt) => Padding(
        padding: EdgeInsets.only(top: 5),
        child: Text(
          txt,
          style: TextStyle(
            color: Colors.blue[500],
            fontSize: 10,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFDDDDDD),
              blurRadius: 1,
              spreadRadius: 0,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label("UUID"),
            Text("$uuid"),
            _label("MajorId"),
            Text("$majorId"),
            _label("MinorId"),
            Text("$minorId"),
            _label("Accuracy(거리정확도)"),
            Text("$accuracy"),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
