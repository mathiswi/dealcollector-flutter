import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dealcollector/search_field.dart';

class Deal {
  // final String dealId;
  final String? description;
  final String name;
  final String imageUrl;
  final String shop;
  final dynamic dealPrice;
  final dynamic regularPrice;
  final String? basePrice;

  Deal(
      {required this.name,
      required this.shop,
      required this.imageUrl,
      required this.dealPrice,
      this.description,
      this.basePrice,
      this.regularPrice});

  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      shop: json['shop'],
      dealPrice: json['dealPrice'],
      regularPrice: json['regularPrice'],
      basePrice: json['basePrice'],
    );
  }
}

class DealList extends StatefulWidget {
  @override
  _DealListState createState() => _DealListState();
}

class _DealListState extends State<DealList> {
  late List<Deal> deals = [];
  late List<Deal> filteredDeals = [];
  String query = '';

  Future<void> fetchDeals() async {
    final response = await http.get(
        Uri.https('r017129kll.execute-api.eu-central-1.amazonaws.com', 'prod'));
    if (response.statusCode == 200) {
      final result = json.decode(utf8.decode(response.bodyBytes));
      Iterable list = result;
      final data = list.map((model) => Deal.fromJson(model)).toList();
      print(data.length);
      setState(() {
        deals = data;
        filteredDeals = data;
      });
    } else {
      throw Exception('Failed to load deals');
    }
  }

  void initState() {
    super.initState();
    fetchDeals();
  }

  Future<bool> checkContain(str, cmp) async {
    return str.contains(cmp);
  }

  searchDeals(String value) async {
    final List<Deal> result = [];
    await Future.forEach(deals, (Deal entry) async {
      final name = entry.name.toLowerCase();
      final description = entry.description?.toLowerCase();
      final search = value.toLowerCase();

      final List<String> stringList = []
        ..addAll(name.split(' '))
        ..addAll(description?.split(' ') ?? []);
      ;
      List<Future<bool>> futures = <Future<bool>>[];

      for (String str in stringList) {
        futures.add(checkContain(str, search));
      }
      final List<bool> matchesQuery = await Future.wait(futures);
      if (matchesQuery.contains(true)) result.add(entry);
    });
    setState(() {
      this.query = value;
      filteredDeals = result;
    });
    // final result = await deals.where((entry) async {
    //   final name = entry.name.toLowerCase();
    //   final description = entry.description?.toLowerCase();
    //   final search = value.toLowerCase();

    //   final List<String> stringList = name.split(' ');
    //   List<Future> futures = <Future>[];

    //   for (String str in stringList) {
    //     futures.add(checkContains(str, search));
    //   }
    //   final result = await Future.wait(futures);

    //   if (description != null) {
    //     return (name.contains(search) || description.contains(search));
    //   } else {
    //     return name.contains(search);
    //   }
    // }).toList();
    // setState(() {
    //   this.query = value;
    //   filteredDeals = result;
    // });
  }

  Widget buildSearch() => SearchField(
        text: query,
        hintText: 'Search Deals..',
        onChanged: searchDeals,
      );

  Widget buildPriceText(dynamic dealPrice, dynamic regularPrice) {
    if (regularPrice == null) {
      return RichText(text: TextSpan(text: dealPrice.toString()));
    } else {
      return RichText(
        text: TextSpan(children: <TextSpan>[
          TextSpan(
              text: regularPrice.toString(),
              style: TextStyle(decoration: TextDecoration.lineThrough)),
          TextSpan(
              text: '€ ',
              style: TextStyle(decoration: TextDecoration.lineThrough)),
          TextSpan(text: regularPrice.toString()),
          TextSpan(text: '€'),
        ]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: buildSearch(),
        ),
        Expanded(
          child: filteredDeals.isNotEmpty
              ? ListView.builder(
                  itemCount: filteredDeals.length,
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    return Card(
                        child: Row(
                      children: [
                        Image.network(
                          filteredDeals[index].imageUrl,
                          scale: 1,
                          height: 70,
                          width: 90,
                          fit: BoxFit.fitHeight,
                          cacheHeight: 355,
                        ),
                        Padding(padding: EdgeInsets.symmetric(horizontal: 6.0)),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                filteredDeals[index].name,
                                overflow: TextOverflow.ellipsis,
                              ),
                              buildPriceText(filteredDeals[index].dealPrice,
                                  filteredDeals[index].regularPrice),
                              Text(
                                  "${filteredDeals[index].basePrice?.toString() ?? ""}"),
                            ],
                          ),
                        )
                      ],
                    ));
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ]),
    );
  }
}
