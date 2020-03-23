// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brazil_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BrazilStore on _BrazilStoreBase, Store {
  final _$statisticsAtom = Atom(name: '_BrazilStoreBase.statistics');

  @override
  BrazilStatistics get statistics {
    _$statisticsAtom.context.enforceReadPolicy(_$statisticsAtom);
    _$statisticsAtom.reportObserved();
    return super.statistics;
  }

  @override
  set statistics(BrazilStatistics value) {
    _$statisticsAtom.context.conditionallyRunInAction(() {
      super.statistics = value;
      _$statisticsAtom.reportChanged();
    }, _$statisticsAtom, name: '${_$statisticsAtom.name}_set');
  }

  final _$statisticsByPeriodAtom =
      Atom(name: '_BrazilStoreBase.statisticsByPeriod');

  @override
  List<BrazilStatistics> get statisticsByPeriod {
    _$statisticsByPeriodAtom.context
        .enforceReadPolicy(_$statisticsByPeriodAtom);
    _$statisticsByPeriodAtom.reportObserved();
    return super.statisticsByPeriod;
  }

  @override
  set statisticsByPeriod(List<BrazilStatistics> value) {
    _$statisticsByPeriodAtom.context.conditionallyRunInAction(() {
      super.statisticsByPeriod = value;
      _$statisticsByPeriodAtom.reportChanged();
    }, _$statisticsByPeriodAtom, name: '${_$statisticsByPeriodAtom.name}_set');
  }

  final _$selectedStateAtom = Atom(name: '_BrazilStoreBase.selectedState');

  @override
  int get selectedState {
    _$selectedStateAtom.context.enforceReadPolicy(_$selectedStateAtom);
    _$selectedStateAtom.reportObserved();
    return super.selectedState;
  }

  @override
  set selectedState(int value) {
    _$selectedStateAtom.context.conditionallyRunInAction(() {
      super.selectedState = value;
      _$selectedStateAtom.reportChanged();
    }, _$selectedStateAtom, name: '${_$selectedStateAtom.name}_set');
  }

  final _$fetchBrazilStatisticsAsyncAction =
      AsyncAction('fetchBrazilStatistics');

  @override
  Future<void> fetchBrazilStatistics() {
    return _$fetchBrazilStatisticsAsyncAction
        .run(() => super.fetchBrazilStatistics());
  }

  final _$fetchBrazilStatisticsByDateAsyncAction =
      AsyncAction('fetchBrazilStatisticsByDate');

  @override
  Future<void> fetchBrazilStatisticsByDate() {
    return _$fetchBrazilStatisticsByDateAsyncAction
        .run(() => super.fetchBrazilStatisticsByDate());
  }

  final _$changeSelectedStateAsyncAction = AsyncAction('changeSelectedState');

  @override
  Future<void> changeSelectedState(String stateName) {
    return _$changeSelectedStateAsyncAction
        .run(() => super.changeSelectedState(stateName));
  }

  @override
  String toString() {
    final string =
        'statistics: ${statistics.toString()},statisticsByPeriod: ${statisticsByPeriod.toString()},selectedState: ${selectedState.toString()}';
    return '{$string}';
  }
}
