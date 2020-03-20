import 'package:dio/dio.dart';

import '../../secrets/api_secrets.dart';
import '../../shared/contants/api_contants.dart';
import '../models/statistics_model.dart';

class StatistcsRepository {
  BaseOptions options = BaseOptions(
    baseUrl: Api.baseUrl,
    headers: ApiSecrets.keys,
  );

  Future<Statistics> fetchStatistics({String country = 'Brazil'}) async {
    final response = await Dio(options).get('?country=$country');
    return Statistics.fromJson(response.data);
  }
}
