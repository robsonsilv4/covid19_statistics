import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: CountryCodePicker(
          onChanged: (county) => print(county.name),
          initialSelection: 'BR',
          showCountryOnly: true,
          showOnlyCountryWhenClosed: true,
          alignLeft: false,
        ),
      )),
    );
  }
}
