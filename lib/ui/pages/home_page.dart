import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../data/repositores/country_repository.dart';
import '../../stores/country_store.dart';
import '../widgets/stats_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final contryStore = CountryStore(
    countryRepository: CountryRepository(
      client: Dio(),
    ),
  );

  @override
  void initState() {
    super.initState();
    if (contryStore.countryStatistics == null) {
      contryStore.fetchCountryStatistics();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(40.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.circular(15.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Selecione o país:',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                SingleChildScrollView(
                  child: CountryCodePicker(
                    onChanged: (county) => print(county.name),
                    initialSelection: 'BR',
                    showCountryOnly: true,
                    showOnlyCountryWhenClosed: true,
                    alignLeft: false,
                    textStyle: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height - 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.0,
                        vertical: 15.0,
                      ),
                      child: Observer(builder: (_) {
                        if (contryStore.countryStatistics != null) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              StatsCard(
                                color: Colors.blue,
                                number: contryStore
                                    .countryStatistics.data.confirmed
                                    .toString(),
                                text: 'Confirmados',
                              ),
                              StatsCard(
                                color: Colors.red,
                                number: contryStore
                                    .countryStatistics.data.deaths
                                    .toString(),
                                text: 'Mortes',
                              ),
                              StatsCard(
                                color: Colors.green,
                                number: contryStore
                                    .countryStatistics.data.recovered
                                    .toString(),
                                text: 'Recuperados',
                              ),
                            ],
                          );
                        }

                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
