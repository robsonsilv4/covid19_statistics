import 'package:mobx/mobx.dart';

import '../data/models/brazil_statistics.dart';
import '../data/repositores/brazil_repository.dart';

part 'brazil_store.g.dart';

class BrazilStore = _BrazilStoreBase with _$BrazilStore;

abstract class _BrazilStoreBase with Store {
  final BrazilRepository brazilRepository;

  _BrazilStoreBase({this.brazilRepository});

  @observable
  BrazilStatistics statistics;

  @action
  Future<void> fetchBrazilStatistics() async {
    statistics = await brazilRepository.fetchStatistics();
  }
}
