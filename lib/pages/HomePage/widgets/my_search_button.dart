// Flutter Packages
import 'package:flutter/material.dart';

// Dart Packages
import 'dart:io';

class MySearchButton extends StatelessWidget {
  const MySearchButton({
    Key? key,
    required File? image,
    required VoidCallback onPressed,
  })  : _image = image,
        _onPressed = onPressed,
        super(key: key);

  final File? _image;
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
      child: _image != null
          ? ElevatedButton(
              onPressed: _onPressed,
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.secondary,
                onPrimary: Theme.of(context).colorScheme.onSecondary,
              ),
              child: const Text('Search this Image'),
            )
          : const SizedBox.shrink(),
    );
  }
}