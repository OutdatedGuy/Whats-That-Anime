// Flutter Packages
import 'package:flutter/material.dart';

class MySearchButton extends StatelessWidget {
  const MySearchButton({
    super.key,
    required bool hidden,
    required VoidCallback onPressed,
  })  : _hidden = hidden,
        _onPressed = onPressed;

  final bool _hidden;
  final VoidCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      switchInCurve: Curves.decelerate,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.6),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      ),
      child: _hidden
          ? const SizedBox.shrink()
          : ElevatedButton(
              onPressed: _onPressed,
              style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onSecondary,
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              child: const Text('Search this Image'),
            ),
    );
  }
}
