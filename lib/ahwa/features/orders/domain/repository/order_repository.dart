import '../entities/order.dart';

abstract class OrderRepository {
  Future<Order> add(Order order);
  Future<void> update(Order order);
  Future<List<Order>> fetchAll();
}
