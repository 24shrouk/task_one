import 'package:flutter/material.dart';

void main() {
  runApp(const TaskOne());
}

class TaskOne extends StatelessWidget {
  const TaskOne({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Content Display Example')),
        body: const Center(
          child: Text('Implement content display in question_one.dart'),
        ),
      ),
    );
  }
}
