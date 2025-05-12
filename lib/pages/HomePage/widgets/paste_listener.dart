// Flutter Packages
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

class PasteListener extends StatefulWidget {
  const PasteListener({super.key, required this.child, required this.onPaste});

  final Widget child;
  final VoidCallback onPaste;

  @override
  State<PasteListener> createState() => _PasteListenerState();
}

class _PasteListenerState extends State<PasteListener> {
  final FocusNode _focusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FocusScope.of(context).requestFocus(_focusNode);
  }

  @override
  Widget build(BuildContext context) {
    final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
    return CallbackShortcuts(
      bindings: {
        SingleActivator(
              LogicalKeyboardKey.keyV,
              control: !isMacOS,
              meta: isMacOS,
              includeRepeats: false,
            ):
            widget.onPaste,
      },
      child: Focus(autofocus: true, focusNode: _focusNode, child: widget.child),
    );
  }
}
