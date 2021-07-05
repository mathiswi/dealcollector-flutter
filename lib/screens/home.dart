import 'dart:async';
import 'package:dealcollector/models/deal.dart';
import 'package:dealcollector/widgets/deal_tile.dart';
import 'package:dealcollector/widgets/deal_list.dart';
import 'package:flutter/material.dart';
import 'package:dealcollector/widgets/search_field.dart';

import 'package:dealcollector/utils/fetch_deals.dart';
import 'package:dealcollector/utils/filter_deals.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: DealList()),
    );
  }
}
