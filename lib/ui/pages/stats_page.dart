import 'package:covid19_statistics/data/repositores/brazil_repository.dart';
import 'package:covid19_statistics/data/repositores/country_repository.dart';
import 'package:covid19_statistics/shared/contants/covid19_constants.dart';
import 'package:covid19_statistics/stores/brazil_store.dart';
import 'package:covid19_statistics/stores/country_store.dart';
import 'package:covid19_statistics/ui/widgets/info_item.dart';
import 'package:covid19_statistics/ui/widgets/loading.dart';
import 'package:covid19_statistics/ui/widgets/share_button.dart';
import 'package:covid19_statistics/ui/widgets/stats_card.dart';
import 'package:dio/dio.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

class StatsWidget extends StatefulWidget {
  @override
  _StatsWidgetState createState() => _StatsWidgetState();
}

class _StatsWidgetState extends State<StatsWidget> {
  final today = DateFormat('dd-MM-yyyy').format(DateTime.now());

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

    store.fetchBrazilStatistics();
    countryStore.fetchCountryStatistics();

    if (store.statistics.data.isEmpty) {
      store.fetchBrazilStatistics();
    }

    if (countryStore.statistics == null) {
      countryStore.fetchCountryStatistics();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.topCenter, children: <Widget>[
      Container(
        height: MediaQuery.of(context).size.height - 200,
        decoration: BoxDecoration(
          color: Color(0xffa6d3d8),
          image: DecorationImage(
            image: AssetImage(Covid19.background),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 35.0),
        child: Container(
          margin: EdgeInsets.all(30.0),
          padding: EdgeInsets.only(
            top: 19.0,
            left: 15.0,
            right: 15.0,
          ),
          height: 115.0,
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
                height: 10.0,
              ),
              FindDropdown(
                items: Covid19.brazilianStates,
                onChanged: (String item) async {
                  store.changeSelectedState(item);
                  setState(
                    () {},
                  );
                },
                selectedItem: 'Minas Gerais',
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
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 1.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4.0, // has the effect of softening the shadow
                    spreadRadius: 1.0 // has the effect of extending the shadow
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
                          'SITUAÇÃO: ${statistics[index].state.toUpperCase()}',
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

                    return Loading();
                  }),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      _cardTitle(text: 'SITUAÇÃO NO BRASIL'),
                      SizedBox(width: 8.0),
                      Text(
                        today.toString(),
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
                        final countyStatistics = countryStore.statistics.data;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            InfoItem(
                              text: 'Confirmados',
                              number: countyStatistics.cases,
                              color: Colors.indigo,
                            ),
                            InfoItem(
                              text: 'Ativos',
                              number: countyStatistics.confirmed,
                              color: Colors.orange,
                            ),
                            InfoItem(
                              text: 'Recuperados',
                              number: countyStatistics.recovered,
                              color: Colors.green,
                            ),
                            InfoItem(
                              text: 'Mortos',
                              number: countyStatistics.deaths,
                              color: Colors.red,
                            ),
                          ],
                        );
                      }
                      return Loading();
                    }),
                  ),
                ),
                ShareButton(),
              ],
            ),
          )
        ],
      ),
    ]);
  }
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
