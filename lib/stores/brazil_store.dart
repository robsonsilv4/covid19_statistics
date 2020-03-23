import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

import '../data/models/brazil_statistics.dart';
import '../data/repositores/brazil_repository.dart';

part 'brazil_store.g.dart';

class BrazilStore = _BrazilStoreBase with _$BrazilStore;

abstract class _BrazilStoreBase with Store {
  final BrazilRepository brazilRepository;

  _BrazilStoreBase({this.brazilRepository});

  @observable
  BrazilStatistics statistics = BrazilStatistics(data: List.of([]));

  @observable
  List<BrazilStatistics> statisticsByPeriod = new ObservableList<BrazilStatistics>.of([]);

  @observable
  int selectedState = 12;

  @action
  Future<void> fetchBrazilStatistics() async {
    statistics = await brazilRepository.fetchStatistics();
  }

  @action
  Future<void> fetchBrazilStatisticsByDate() async {
    for (var i = 1; i < 15; i++) {
      var now = new DateTime.now();
      var date = new DateTime(now.year, now.month, now.day - i);
      var formatter = new DateFormat('yyyyMMdd');
      String formatted = formatter.format(date);
      var stats = await brazilRepository.fetchStatisticsForPeriod(formatted);
      statisticsByPeriod.add(stats);
    }
  }

  @action
  Future<void> changeSelectedState(String stateName) async {
    if (statistics.data.isNotEmpty) {
      statistics.data.asMap().forEach((index, state) {
        if (state.state == stateName) {
          selectedState = index;
        }
      });
    }
  }
}
