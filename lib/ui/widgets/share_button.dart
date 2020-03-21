import 'package:flutter/material.dart';

class ShareButton extends StatelessWidget {
  final Function onPress;

  const ShareButton({Key key, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Compartilhar',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          Icon(
            Icons.share,
            color: Colors.white,
          ),
        ],
      ),
      color: Colors.greenAccent,
      padding: EdgeInsets.all(15.0),
      onPressed: onPress ?? () => {},
    );
  }
}
