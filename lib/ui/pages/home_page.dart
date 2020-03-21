import 'package:dio/dio.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../data/repositores/brazil_repository.dart';
import '../../data/repositores/country_repository.dart';
import '../../shared/contants/covid19_constants.dart';
import '../../stores/brazil_store.dart';
import '../../stores/country_store.dart';
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

  final countryStore = CountryStore(
    countryRepository: CountryRepository(
      client: Dio(),
    ),
  );

  @override
  void initState() {
    super.initState();

    if (store.statistics.data.isEmpty) {
      store.fetchBrazilStatistics();
    }

    if (countryStore.statistics == null) {
      countryStore.fetchCountryStatistics();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 200,
            decoration: BoxDecoration(
              color: Color(0xffa6d3d8),
              image: DecorationImage(
                image: AssetImage('images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(40.0),
            padding: EdgeInsets.only(
              top: 19.0,
              left: 15.0,
              right: 15.0,
            ),
            height: 105.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4.0, // has the effect of softening the shadow
                  spreadRadius: 2.0, // has the effect of extending the shadow
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Selecione o estado:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                FindDropdown(
                  items: Covid19.brazilianStates,
                  onChanged: (String item) async {
                    store.changeSelectedState(item);
                    setState(
                      () {},
                    );
                  },
                  selectedItem: 'Ceará',
                  showSearchBox: true,
                  validate: (String item) {
                    if (item == null) {
                      return 'É preciso selecionar um estado.';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height / 1.6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius:
                              4.0, // has the effect of softening the shadow
                          spreadRadius:
                              1.0 // has the effect of extending the shadow
                          )
                    ],
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      Observer(builder: (_) {
                        if (store.statistics.data.isNotEmpty) {
                          final statistics = store.statistics.data;
                          final index = store.selectedState;

                          return _cardTitle(
                            text:
                                'SITUAÇÃO NO ${statistics[index].uf.toUpperCase()}',
                          );
                        }

                        return _cardTitle(text: 'CARREGANDO INFORMAÇÕES...');
                      }),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        child: Observer(builder: (_) {
                          if (store.statistics.data.isNotEmpty) {
                            final statistics = store.statistics.data;

                            return Container(
                              height: 80.0, // Mesmo tamanho
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  StatsCard(
                                    color: Colors.indigo,
                                    number: statistics[store.selectedState]
                                        .cases
                                        .toString(),
                                    text: 'Confirmados',
                                  ),
                                  StatsCard(
                                    color: Colors.red,
                                    number: statistics[store.selectedState]
                                        .deaths
                                        .toString(),
                                    text: 'Mortes',
                                  ),
                                  StatsCard(
                                    color: Colors.orange,
                                    number: statistics[store.selectedState]
                                        .suspects
                                        .toString(),
                                    text: 'Suspeitos',
                                  ),
                                  StatsCard(
                                    color: Colors.green,
                                    number: statistics[store.selectedState]
                                        .refuses
                                        .toString(),
                                    text: 'Descartados',
                                  ),
                                ],
                              ),
                            );
                          }

                          return _loading();
                        }),
                      ),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0, bottom: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'SITUAÇÃO NO BRASIL',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.8),
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              DateFormat('dd-MM-yyyy')
                                  .format(DateTime.now())
                                  .toString(),
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Observer(builder: (_) {
                            if (countryStore.statistics != null) {
                              final countyStatistics =
                                  countryStore.statistics.data;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  _infoItem(
                                    text: 'Confirmados',
                                    number: countyStatistics.cases,
                                    color: Colors.indigo,
                                  ),
                                  _infoItem(
                                    text: 'Ativos',
                                    number: countyStatistics.confirmed,
                                    color: Colors.orange,
                                  ),
                                  _infoItem(
                                    text: 'Recuperados',
                                    number: countyStatistics.recovered,
                                    color: Colors.green,
                                  ),
                                  _infoItem(
                                    text: 'Mortos',
                                    number: countyStatistics.deaths,
                                    color: Colors.red,
                                  ),
                                ],
                              );
                            }

                            return _loading();
                          }),
                        ),
                      ),
                      RaisedButton(
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
                        onPressed: () => {},
                      )
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }

  Widget _cardTitle({@required String text}) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.black.withOpacity(0.8),
        ),
      ),
    );
  }

  Widget _loading() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _infoItem({String text, int number, Color color}) {
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
