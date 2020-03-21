import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final double padding;

  const Loading({Key key, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(padding ?? 15.0),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
