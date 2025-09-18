import 'package:flutter/material.dart';

/// Contract for navigable screens
abstract class Navigable {
  void navigate(BuildContext context);
}

/// Base screen class (common properties if needed)
abstract class Screen {}

/// A navigable screen
class HomeScreen extends Screen implements Navigable {
  @override
  void navigate(BuildContext context) {
    print('Navigating to Home');
    // Example navigation
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }
}

/// A non-navigable screen
class SettingsScreen extends Screen {
  // No navigation behavior here
}

/// Navigation button only works with Navigable screens
class NavigationButton extends StatelessWidget {
  final Navigable screen;
  const NavigationButton(this.screen, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => screen.navigate(context),
      child: const Text('Navigate'),
    );
  }
}

/// Example HomePage Widget
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Welcome Home!')));
  }
}
