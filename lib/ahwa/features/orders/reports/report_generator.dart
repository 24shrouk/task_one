import 'package:task_one/ahwa/features/orders/domain/entities/order.dart';

abstract class ReportGenerator {
  Map<String, dynamic> generate(List<Order> orders);
}
