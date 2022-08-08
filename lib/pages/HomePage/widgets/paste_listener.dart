// Copyright (C) 2022 OutdatedGuy
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

// Flutter Packages
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

class PasteListener extends StatefulWidget {
  const PasteListener({
    Key? key,
    required this.child,
    required this.onPaste,
  }) : super(key: key);

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
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(
          LogicalKeyboardKey.keyV,
          control: true,
          includeRepeats: false,
        ): widget.onPaste,
      },
      child: Focus(
        autofocus: true,
        focusNode: _focusNode,
        child: widget.child,
      ),
    );
  }
}
