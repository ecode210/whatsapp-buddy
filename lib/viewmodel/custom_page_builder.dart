import 'package:flutter/cupertino.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  final AxisDirection direction;

  CustomPageRoute({
    required this.child,
    required this.direction,
  }) : super(
          transitionDuration: const Duration(milliseconds: 200),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: getDirection(),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  Offset getDirection() {
    switch (direction) {
      case AxisDirection.up:
        return const Offset(0, -1);
      case AxisDirection.down:
        return const Offset(0, 1);
      case AxisDirection.right:
        return const Offset(-1, 0);
      case AxisDirection.left:
        return const Offset(1, 0);
      default:
        return const Offset(0, -1);
    }
  }
}
