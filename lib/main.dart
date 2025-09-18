import 'package:flutter/material.dart';

import 'package:task_one/ahwa/features/orders/data/repository/in_memory_order_repository.dart';
import 'package:task_one/ahwa/features/orders/domain/use_case/order_manager.dart';
import 'package:task_one/ahwa/features/orders/presentation/screens/home_screen.dart';

void main() {
  runApp(const AhwaApp());
}

class AhwaApp extends StatelessWidget {
  const AhwaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = InMemoryOrderRepository();
    final manager = OrderManager(repo);

    return MaterialApp(
      title: 'Smart Ahwa Manager',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: HomeScreen(manager: manager),
    );
  }
}
