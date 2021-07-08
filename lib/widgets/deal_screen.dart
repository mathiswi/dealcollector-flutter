import 'package:flutter/material.dart';

import '../../models/deal.dart';
import '../../utils.dart';
import '../../utils/api_provider.dart';
import '../../utils/filter_deals.dart';
import '../../widgets/deal_list.dart';
import '../../widgets/search_field.dart';
import '../../widgets/sidebar.dart';

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
  final ScrollController scrollController = ScrollController();
  final ApiProvider apiProvider = ApiProvider();

  Future<void> getDeals() async {
    final List<Deal> data = await apiProvider.fetchData(widget.shopName);
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
    if (scrollController.hasClients && scrollController.offset != 0.0) {
      scrollController.animateTo(scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOutCubic);
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
              deals: filteredDeals, scrollController: scrollController)),
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
