import 'package:flutter/material.dart';

class InfoItem extends StatelessWidget {
  final String text;
  final int number;
  final Color color;

  const InfoItem({
    Key key,
    this.text,
    this.number,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey.shade600,
            ),
          ),
          Row(
            children: <Widget>[
              Text(
                number.toString(),
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(width: 10.0),
              Container(
                height: 15.0,
                width: 15.0,
                decoration: BoxDecoration(
                  color: color ?? Colors.white,
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
