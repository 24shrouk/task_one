abstract class BasicController {
  void initState();
  void dispose();
}

abstract class Animatable {
  void handleAnimation();
}

abstract class Networkable {
  void handleNetwork();
}

class SimpleButtonController implements BasicController {
  @override
  void initState() => print('Init button');

  @override
  void dispose() => print('Dispose button');
}

class AnimatedButtonController implements BasicController, Animatable {
  @override
  void initState() => print('Init animated button');

  @override
  void dispose() => print('Dispose animated button');

  @override
  void handleAnimation() => print('Handling animation for button');
}

class NetworkWidgetController implements BasicController, Networkable {
  @override
  void initState() => print('Init network widget');

  @override
  void dispose() => print('Dispose network widget');

  @override
  void handleNetwork() => print('Handling network request');
}
