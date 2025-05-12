// Flutter Packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveAction extends StatelessWidget {
  const AdaptiveAction({
    super.key,
    this.onPressed,
    required this.child,
    this.isDestructive = false,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final destructiveColor = Theme.of(context).colorScheme.error;
    return switch (Theme.of(context).platform) {
      TargetPlatform.iOS || TargetPlatform.macOS => CupertinoDialogAction(
        onPressed: onPressed,
        isDestructiveAction: isDestructive,
        child: child,
      ),
      _ => TextButton(
        onPressed: onPressed,
        style:
            isDestructive
                ? TextButton.styleFrom(
                  foregroundColor: destructiveColor,
                  disabledForegroundColor: destructiveColor.withValues(
                    alpha: 0.5,
                  ),
                )
                : null,
        child: child,
      ),
    };
  }
}
