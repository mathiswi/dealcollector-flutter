import 'package:flutter/material.dart';
import '../../models/deal.dart';
import '../../widgets/deal_tile.dart';

class DealList extends StatelessWidget {
  final List<Deal> deals;
  final ScrollController scrollController;
  const DealList(
      {Key? key, required this.deals, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: deals.isNotEmpty
              ? ListView.builder(
                  controller: scrollController,
                  itemCount: deals.length,
                  itemBuilder: (context, index) {
                    return DealTile(deal: deals[index]);
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
