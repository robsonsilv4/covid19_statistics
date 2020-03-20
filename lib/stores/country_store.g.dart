// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CountryStore on _CountryStoreBase, Store {
  final _$countryStatisticsAtom =
      Atom(name: '_CountryStoreBase.countryStatistics');

  @override
  CountryStatistics get countryStatistics {
    _$countryStatisticsAtom.context.enforceReadPolicy(_$countryStatisticsAtom);
    _$countryStatisticsAtom.reportObserved();
    return super.countryStatistics;
  }

  @override
  set countryStatistics(CountryStatistics value) {
    _$countryStatisticsAtom.context.conditionallyRunInAction(() {
      super.countryStatistics = value;
      _$countryStatisticsAtom.reportChanged();
    }, _$countryStatisticsAtom, name: '${_$countryStatisticsAtom.name}_set');
  }

  final _$fetchCountryStatisticsAsyncAction =
      AsyncAction('fetchCountryStatistics');

  @override
  Future<void> fetchCountryStatistics() {
    return _$fetchCountryStatisticsAsyncAction
        .run(() => super.fetchCountryStatistics());
  }

  @override
  String toString() {
    final string = 'countryStatistics: ${countryStatistics.toString()}';
    return '{$string}';
  }
}
