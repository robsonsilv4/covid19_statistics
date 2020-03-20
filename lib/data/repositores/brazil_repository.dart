import 'package:dio/dio.dart';

import '../../shared/contants/api_contants.dart';
import '../models/brazil_statistics.dart';

class BrazilRepository {
  final Dio client;

  BrazilRepository({this.client});

  Future<BrazilStatistics> fetchStatistics() async {
    final response = await client.get(Api.baseUrl + Api.brazilStatistics);
    return BrazilStatistics.fromJson(response.data);
  }
}
