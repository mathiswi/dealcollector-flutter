import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:dealcollector/models/deal.dart';

Future<List<Deal>> fetchDeals([String? shopName]) async {
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
