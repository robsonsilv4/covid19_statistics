import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  final Color color;
  final String number;
  final String text;
  final double padding;

  const StatsCard({
    Key key,
    this.color,
    this.number,
    this.text,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: color ?? Colors.white,
      child: Padding(
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10.0,
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              number,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
