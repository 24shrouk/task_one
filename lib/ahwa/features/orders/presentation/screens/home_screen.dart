import 'package:flutter/material.dart';
import 'package:task_one/ahwa/features/orders/domain/use_case/order_manager.dart';
import 'package:task_one/ahwa/features/orders/reports/top_selling_report.dart';
import '../../domain/entities/order.dart';

class HomeScreen extends StatefulWidget {
  final OrderManager manager;
  const HomeScreen({required this.manager, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _nameCtl = TextEditingController();
  final _instrCtl = TextEditingController();
  String _selectedDrink = 'shai';
  List<Order> _pending = [];

  final List<String> drinks = ['shai', 'turkish', 'hibiscus', 'karkadeh'];

  @override
  void initState() {
    super.initState();
    _reloadPending();
  }

  Future<void> _reloadPending() async {
    final pend = await widget.manager.pendingOrders();
    setState(() => _pending = pend);
  }

  Future<void> _addOrder() async {
    final name = _nameCtl.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Enter customer name')));
      return;
    }
    await widget.manager.addOrder(
      customerName: name,
      drinkType: _selectedDrink,
      instructions: _instrCtl.text.trim(),
    );
    _nameCtl.clear();
    _instrCtl.clear();
    await _reloadPending();
  }

  Future<void> _completeOrder(int id) async {
    await widget.manager.markCompleted(id);
    await _reloadPending();
  }

  Future<void> _showReport() async {
    final report = await widget.manager.generateReport(TopSellingReport());
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Daily Report'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Total served (completed): ${report['totalCompleted']}'),
            const SizedBox(height: 8),
            const Text('Top Selling:'),
            ...(report['topSelling'] as List)
                .map((e) => Text('${e['drink']}: ${e['count']}'))
                .toList(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameCtl.dispose();
    _instrCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Ahwa Manager'),
        actions: [
          IconButton(
            onPressed: _showReport,
            icon: const Icon(Icons.bar_chart),
            tooltip: 'Generate Report',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Add order form
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    TextField(
                      controller: _nameCtl,
                      decoration: const InputDecoration(
                        labelText: 'Customer name',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text('Drink: '),
                        const SizedBox(width: 8),
                        DropdownButton<String>(
                          value: _selectedDrink,
                          items: drinks
                              .map(
                                (d) =>
                                    DropdownMenuItem(value: d, child: Text(d)),
                              )
                              .toList(),
                          onChanged: (v) {
                            if (v != null) setState(() => _selectedDrink = v);
                          },
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: TextField(
                            controller: _instrCtl,
                            decoration: const InputDecoration(
                              labelText: 'Instructions (e.g., extra mint)',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: _addOrder,
                      icon: const Icon(Icons.add),
                      label: const Text('Add Order'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Pending orders
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      const Text(
                        'Pending Orders',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: _pending.isEmpty
                            ? const Center(child: Text('No pending orders'))
                            : ListView.builder(
                                itemCount: _pending.length,
                                itemBuilder: (ctx, i) {
                                  final o = _pending[i];
                                  return ListTile(
                                    title: Text(
                                      '${o.customerName} — ${o.drinkType}',
                                    ),
                                    subtitle: Text(
                                      o.instructions.isEmpty
                                          ? '—'
                                          : o.instructions,
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ),
                                      onPressed: () =>
                                          _completeOrder(o.orderId),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
