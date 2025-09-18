import 'package:task_one/ahwa/features/orders/domain/entities/order.dart';

import 'report_generator.dart';

class TopSellingReport implements ReportGenerator {
  @override
  Map<String, dynamic> generate(List<Order> orders) {
    final Map<String, int> counts = {};
    for (var o in orders.where((e) => e.status == OrderStatus.completed)) {
      counts[o.drinkType] = (counts[o.drinkType] ?? 0) + 1;
    }
    final sorted = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return {
      'totalCompleted': counts.values.fold<int>(0, (p, e) => p + e),
      'topSelling': sorted
          .map((e) => {'drink': e.key, 'count': e.value})
          .toList(),
    };
  }
}
