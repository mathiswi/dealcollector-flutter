import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../../models/deal.dart';

class ApiProvider {
  Future<List<Deal>> fetchData([String? shopName]) async {
    final String path = shopName != null ? 'prod/$shopName' : 'prod';
    final response = await http.get(
        Uri.https('r017129kll.execute-api.eu-central-1.amazonaws.com', path));
    if (response.statusCode == 200) {
      final result = json.decode(utf8.decode(response.bodyBytes));
      final dynamic list = result;
      final List<Deal> data = list
          .map((model) => Deal.fromJson(model as Map<String, dynamic>))
          .toList() as List<Deal>;
      return data;
    } else {
      throw Exception('Failed to load deals');
    }
  }
}
