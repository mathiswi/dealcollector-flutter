import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

import '../../models/deal.dart';
import '../../utils.dart';

class DealTile extends StatelessWidget {
  final Deal deal;

  const DealTile({Key? key, required this.deal}) : super(key: key);

  RichText buildPriceText(dynamic dealPrice, dynamic basePrice) {
    if (basePrice == null) {
      return RichText(
          text: TextSpan(
        text: dealPrice.toString(),
        style: const TextStyle(fontSize: 16),
      ));
    } else {
      return RichText(
        text:
            TextSpan(style: const TextStyle(fontSize: 16), children: <TextSpan>[
          TextSpan(
              text: dealPrice.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const TextSpan(
            text: '€ ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: basePrice as String,
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
        ]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.symmetric(horizontal: 20.0)),
            Align(
                child: CachedNetworkImage(
              imageUrl: deal.imageUrl,
              height: 90,
              fadeInDuration: const Duration(milliseconds: 0),
              fadeOutDuration: const Duration(milliseconds: 0),
              placeholder: (context, url) => SizedBox(
                width: 150.0,
                height: 100.0,
                child: Shimmer.fromColors(
                    period: const Duration(milliseconds: 1000),
                    baseColor: Colors.grey.shade600,
                    highlightColor: Colors.grey.shade500,
                    child: Container(
                      color: Colors.grey,
                    )),
              ),
            )),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                  Text(
                    deal.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    deal.regularPrice?.toString() ?? "",
                    style:
                        const TextStyle(decoration: TextDecoration.lineThrough),
                  ),
                  buildPriceText(deal.dealPrice, deal.basePrice),
                  Text(deal.shop.capitalizeFirstofEach),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
