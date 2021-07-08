import '../../models/deal.dart';

Future<bool> checkContain(String str, String cmp) async {
  return str.contains(cmp);
}

Future<List<Deal>> filterDeals(String value, List<Deal> deals) async {
  final List<Deal> result = [];
  await Future.forEach(deals, (Deal entry) async {
    final name = entry.name.toLowerCase();
    final description = entry.description?.toLowerCase();
    final search = value.toLowerCase();

    final List<String> stringList = [
      ...name.split(' '),
      ...description?.split('') ?? []
    ];
    final List<Future<bool>> futures = <Future<bool>>[];

    for (final String str in stringList) {
      futures.add(checkContain(str, search));
    }
    final List<bool> matchesQuery = await Future.wait(futures);
    if (matchesQuery.contains(true)) result.add(entry);
  });
  return result;
}
