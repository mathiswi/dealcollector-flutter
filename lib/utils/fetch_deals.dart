import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:dealcollector/models/deal.dart';


class ApiProvider {
  Future<List<Deal>> fetchData([String? shopName]) async {
  print(shopName);
  final String path = shopName != null ? 'prod/${shopName}' : 'prod';
  final response = await http.get(
      Uri.https('r017129kll.execute-api.eu-central-1.amazonaws.com', path));
  if (response.statusCode == 200) {
    final result = json.decode(utf8.decode(response.bodyBytes));
    Iterable list = result;
    final data = list.map((model) => Deal.fromJson(model)).toList();
    return data;
  } else {
    throw Exception('Failed to load deals');
  }
}


// Future<List<Deal>> fetchDeals([String? shopName]) async {
//   print(shopName);
//   final String path = shopName != null ? 'prod/${shopName}' : 'prod';
//   final response = await http.get(
//       Uri.https('r017129kll.execute-api.eu-central-1.amazonaws.com', path));
//   if (response.statusCode == 200) {
//     final result = json.decode(utf8.decode(response.bodyBytes));
//     Iterable list = result;
//     final data = list.map((model) => Deal.fromJson(model)).toList();
//     return data;
//   } else {
//     throw Exception('Failed to load deals');
//   }
// }
