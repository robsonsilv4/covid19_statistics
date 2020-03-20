import 'package:mobx/mobx.dart';

import '../data/models/country_statistics.dart';
import '../data/repositores/country_repository.dart';

part 'country_store.g.dart';

class CountryStore = _CountryStoreBase with _$CountryStore;

abstract class _CountryStoreBase with Store {
  final CountryRepository countryRepository;

  _CountryStoreBase({this.countryRepository});

  @observable
  CountryStatistics statistics;

  @action
  Future<void> fetchCountryStatistics() async {
    statistics = await countryRepository.fetchStatistics(country: 'brazil');
  }
}
