enum OrderStatus { pending, completed }

class Order {
  final int id;
  String _customerName;
  final String drinkType;
  String _instructions;
  OrderStatus _status;
  final DateTime createdAt;

  Order({
    required this.id,
    required String customerName,
    required this.drinkType,
    String instructions = '',
  }) : _customerName = customerName,
       _instructions = instructions,
       _status = OrderStatus.pending,
       createdAt = DateTime.now();

  int get orderId => id;
  String get customerName => _customerName;
  set customerName(String v) {
    if (v.trim().isEmpty) throw ArgumentError('Name cannot be empty');
    _customerName = v;
  }

  String get instructions => _instructions;
  set instructions(String v) => _instructions = v;

  OrderStatus get status => _status;
  void markCompleted() => _status = OrderStatus.completed;

  @override
  String toString() =>
      'Order(id:$id, name:${_customerName}, drink:$drinkType, status:$_status)';
}
