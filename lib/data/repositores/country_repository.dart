import 'package:dio/dio.dart';

import '../../shared/contants/api_contants.dart';
import '../models/country_statistics.dart';

class CountryRepository {
  final Dio client;

  CountryRepository({this.client});

  Future<CountryStatistics> fetchStatistics({String country = 'brazil'}) async {
    final response =
        await client.get(Api.baseUrl + Api.countryStatistics + country);
    return CountryStatistics.fromJson(response.data);
  }
}
