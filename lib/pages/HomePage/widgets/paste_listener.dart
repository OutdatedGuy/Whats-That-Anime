// Flutter Packages
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

class PasteListener extends StatelessWidget {
  const PasteListener({
    Key? key,
    required this.child,
    required this.onPaste,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onPaste;

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(
          LogicalKeyboardKey.keyV,
          control: true,
          includeRepeats: false,
        ): onPaste,
      },
      child: Focus(
        autofocus: true,
        child: child,
      ),
    );
  }
}
