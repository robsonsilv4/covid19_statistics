import 'package:covid19_statistics/data/repositores/brazil_repository.dart';
import 'package:covid19_statistics/shared/contants/covid19_constants.dart';
import 'package:covid19_statistics/stores/brazil_store.dart';
import 'package:covid19_statistics/ui/widgets/loading.dart';
import 'package:covid19_statistics/ui/widgets/stats_graph.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:latlong/latlong.dart';
import 'package:map_markers/map_markers.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController controller = MapController();

  final store = BrazilStore(
    brazilRepository: BrazilRepository(
      client: Dio(),
    ),
  );
  var markers = List<Marker>();

  @override
  void initState() {
    super.initState();
    store.fetchBrazilStatisticsByDate();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Column(children: <Widget>[
        Expanded(
          child: FlutterMap(
            mapController: controller,
            options: MapOptions(
                center: LatLng(-15.855, -51.756),
                zoom: 4.3,
                onPositionChanged: (position, hasGesture) {
                  print(position.zoom);
                },
                plugins: [MarkerClusterPlugin()]),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://api.mapbox.com/styles/v1/mapbox/light-v10/tiles/512/{z}/{x}/{y}?access_token={accessToken}",
                additionalOptions: {
                  'accessToken':
                      'pk.eyJ1IjoiYmV0dGRvdWdpZSIsImEiOiJjaml4MzlieGcyM25yM3JvM3JjMWs0bzB3In0.o339es_Y4jOFIjIH_n38Lg',
                },
              ),
              MarkerClusterLayerOptions(
                maxClusterRadius: 60,
                size: Size(40, 40),
                fitBoundsOptions: FitBoundsOptions(
                  padding: EdgeInsets.all(50),
                ),
                markers: Covid19.brazilianCoordinatesStates
                    .map((e) => showPlaceMarker(e))
                    .toList(),
                builder: (context, markers) => FloatingActionButton(
                  onPressed: null,
                  backgroundColor: Colors.cyanAccent.withOpacity(0.3),
                  child: Text(markers.length.toString()),
                ),
              ),
            ],
          ),
        ),
      ]);
    });
  }

  Marker showPlaceMarker(String state) {
    return Marker(
      point: LatLng(
          double.parse(state.split(",")[1]), double.parse(state.split(",")[2])),
      builder: (context) => BubbleMarker(
        bubbleColor: Colors.white,
        key: UniqueKey(),
        bubbleContentWidgetBuilder: (context) => Text(state.split(",")[0]),
        widgetBuilder: (context) => InkWell(
          child: Icon(
            Icons.place,
            color: Colors.black,
          ),
          onTap: () {
            showCountryGraph(context, state);
          },
        ),
      ),
      height: 150,
      width: 100,
    );
  }

  void showCountryGraph(BuildContext context, String state) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Observer(builder: (_) {
          return Container(
            height: 350,
            child: BottomSheet(
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              clipBehavior: Clip.hardEdge,
              builder: (context) {
                if (store.statisticsByPeriod.isNotEmpty) {
                  final statistics = store.statisticsByPeriod;
                  return Center(
                    child: GraphStats(statistics, state.split(",")[0])
                  );
                }
                return Loading();
              },
              onClosing: () {
                print(state);
              },
            ),
          );
        });
      },
    );
  }
}
