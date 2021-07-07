import 'package:flutter/material.dart';
import 'package:dealcollector/widgets/deal_list.dart';
import 'package:dealcollector/widgets/sidebar.dart';
import 'package:dealcollector/models/deal.dart';
import 'package:dealcollector/utils/fetch_deals.dart';
import 'package:dealcollector/utils/filter_deals.dart';
import 'package:dealcollector/widgets/search_field.dart';
import 'package:dealcollector/utils.dart';

class DealScreen extends StatefulWidget {
  final String? shopName;
  const DealScreen({
    Key? key,
    this.shopName,
  }) : super(key: key);

  @override
  State<DealScreen> createState() => _DealScreenState();
}

class _DealScreenState extends State<DealScreen> {
  String query = '';
  late List<Deal> deals = [];
  late List<Deal> filteredDeals = [];
  final ScrollController _scrollController = ScrollController();
  final ApiProvider _apiProvider = new ApiProvider();

  Future<void> getDeals() async {
    final List<Deal> data = await _apiProvider.fetchData(widget.shopName);
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

  String buildHintText() {
    if (widget.shopName != null) {
      return 'Search ${widget.shopName?.capitalizeFirstofEach} Deals..';
    } else {
      return 'Search Deals...';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: DealList(
              deals: filteredDeals, scrollController: _scrollController)),
      drawer: SafeArea(child: Sidebar()),
      appBar: AppBar(
        title: SearchField(
          text: query,
          hintText: buildHintText(),
          onChanged: searchDeals,
        ),
      ),
    );
  }
}
/*
 child: SearchField(
            text: query,
            hintText: 'Search Deals..',
            onChanged: searchDeals,
          ),
*/