import 'dart:async';
import 'package:dealcollector/models/deal.dart';
import 'package:dealcollector/widgets/deal_tile.dart';
import 'package:flutter/material.dart';
import 'package:dealcollector/widgets/search_field.dart';

import 'package:dealcollector/utils/fetch_deals.dart';
import 'package:dealcollector/utils/filter_deals.dart';

class DealList extends StatefulWidget {
  final String? shopName;
  const DealList({Key? key, this.shopName}) : super(key: key);

  @override
  _DealListState createState() => _DealListState();
}

class _DealListState extends State<DealList> {
  final ScrollController _scrollController = ScrollController();
  String query = '';
  late List<Deal> deals = [];
  late List<Deal> filteredDeals = [];

  Future<void> getDeals() async {
    final List<Deal> data = await fetchDeals();
    setState(() {
      deals = data;
      filteredDeals = data;
    });
  }

  Future<void> searchDeals(String value) async {
    final List<Deal> result = await filterDeals(value, deals);
    setState(() {
      query = value;
      filteredDeals = result;
    });
    if (_scrollController.hasClients && _scrollController.offset != 0.0) {
      _scrollController.animateTo(_scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 100), curve: Curves.easeOutCubic);
    }
  }

  @override
  void initState() {
    super.initState();
    getDeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: SearchField(
            text: query,
            hintText: 'Search Deals..',
            onChanged: searchDeals,
          ),
        ),
        Expanded(
          child: filteredDeals.isNotEmpty
              ? ListView.builder(
                  controller: _scrollController,
                  itemCount: filteredDeals.length,
                  itemBuilder: (context, index) {
                    return DealTile(deal: filteredDeals[index]);
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
