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
  int selectedState = 9;

  @action
  Future<void> fetchBrazilStatistics() async {
    statistics = await brazilRepository.fetchStatistics();
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
