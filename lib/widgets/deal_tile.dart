import 'package:dealcollector/models/deal.dart';
import 'package:dealcollector/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DealTile extends StatelessWidget {
  final Deal deal;

  const DealTile({Key? key, required this.deal}) : super(key: key);

  RichText buildPriceText(dynamic dealPrice, dynamic basePrice) {
    if (basePrice == null) {
      return RichText(
          text: TextSpan(
        text: dealPrice.toString(),
        style: TextStyle(fontSize: 16),
      ));
    } else {
      return RichText(
        text: TextSpan(style: TextStyle(fontSize: 16), children: <TextSpan>[
          TextSpan(
              text: dealPrice.toString(),
              style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
            text: '€ ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: basePrice,
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: (Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: 20.0)),
            Align(
              alignment: Alignment.center,
              child: Image.network(
                deal.imageUrl,
                height: 90,
                cacheHeight: 355,
              ),
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                  Text(
                    deal.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    deal.regularPrice?.toString() ?? "",
                    style: TextStyle(decoration: TextDecoration.lineThrough),
                  ),
                  buildPriceText(deal.dealPrice, deal.basePrice),
                  Text(deal.shop.capitalizeFirstofEach),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
