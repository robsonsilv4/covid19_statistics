import 'package:country_code_picker/country_code_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../data/repositores/brazil_repository.dart';
import '../../stores/brazil_store.dart';
import '../widgets/stats_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final store = BrazilStore(
    brazilRepository: BrazilRepository(
      client: Dio(),
    ),
  );

  @override
  void initState() {
    super.initState();

    if (store.statistics == null) {
      store.fetchBrazilStatistics();
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
                  'Selecione o estado:',
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
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 15.0,
                      ),
                      child: Observer(builder: (_) {
                        if (store.statistics != null) {
                          final statistics = store.statistics.data;

                          return Container(
                            height: 80.0, // Mesmo tamanho
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                StatsCard(
                                  color: Colors.indigo,
                                  number: statistics[9].cases.toString(),
                                  text: 'Confirmados',
                                ),
                                StatsCard(
                                  color: Colors.red,
                                  number: statistics[9].deaths.toString(),
                                  text: 'Mortes',
                                ),
                                StatsCard(
                                  color: Colors.orange,
                                  number: statistics[9].suspects.toString(),
                                  text: 'Suspeitos',
                                ),
                                StatsCard(
                                  color: Colors.green,
                                  number: statistics[9].refuses.toString(),
                                  text: 'Descartados',
                                ),
                              ],
                            ),
                          );
                        }

                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: CircularProgressIndicator(),
                          ),
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
