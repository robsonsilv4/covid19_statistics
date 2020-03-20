import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 15.0,
              bottom: 10.0,
            ),
            child: Text(
              'COVID-19 Estatísticas',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          CountryCodePicker(
            onChanged: (county) => print(county.name),
            initialSelection: 'BR',
            showCountryOnly: true,
            showOnlyCountryWhenClosed: true,
            alignLeft: false,
            textStyle: TextStyle(
              fontSize: 16.0,
              // fontWeight: FontWeight.bold,
            ),
          ),
          Text('Última atualização: 20-03-2020'),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _card(
                  color: Colors.blue,
                  number: '5.000',
                  text: 'Confirmados',
                ),
                _card(
                  color: Colors.red,
                  number: '1.000',
                  text: 'Mortes',
                ),
                _card(
                  color: Colors.green,
                  number: '4.000',
                  text: 'Recuperados',
                ),
              ],
            ),
          )
        ],
      )),
    );
  }

  Card _card({Color color, String number, String text, double padding}) {
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
