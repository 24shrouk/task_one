import 'package:task_one/ahwa/features/orders/domain/repository/order_repository.dart';
import 'package:task_one/ahwa/features/orders/reports/report_generator.dart';

import '../entities/order.dart';

class OrderManager {
  final OrderRepository _repo;
  int _nextId = 1;

  OrderManager(this._repo);

  Future<Order> addOrder({
    required String customerName,
    required String drinkType,
    String instructions = '',
  }) async {
    final order = Order(
      id: _nextId++,
      customerName: customerName,
      drinkType: drinkType,
      instructions: instructions,
    );
    await _repo.add(order);
    return order;
  }

  Future<void> markCompleted(int id) async {
    final all = await _repo.fetchAll();
    final order = all.firstWhere(
      (o) => o.id == id,
      orElse: () {
        throw StateError('Order not found');
      },
    );
    order.markCompleted();
    await _repo.update(order);
  }

  Future<List<Order>> pendingOrders() async {
    final all = await _repo.fetchAll();
    return all.where((o) => o.status == OrderStatus.pending).toList();
  }

  Future<Map<String, dynamic>> generateReport(ReportGenerator generator) async {
    final all = await _repo.fetchAll();
    return generator.generate(all);
  }

  Future<List<Order>> allOrders() async => _repo.fetchAll();
}
