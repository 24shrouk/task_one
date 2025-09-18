import 'package:task_one/ahwa/features/orders/domain/repository/order_repository.dart';

import '../../domain/entities/order.dart';

class InMemoryOrderRepository implements OrderRepository {
  final List<Order> _store = [];

  @override
  Future<Order> add(Order order) async {
    _store.add(order);
    return order;
  }

  @override
  Future<void> update(Order order) async {
    final idx = _store.indexWhere((o) => o.id == order.id);
    if (idx >= 0) _store[idx] = order;
  }

  @override
  Future<List<Order>> fetchAll() async => List.unmodifiable(_store);
}
