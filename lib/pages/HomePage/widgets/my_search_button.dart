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
import 'package:flutter/material.dart';

class MySearchButton extends StatelessWidget {
  const MySearchButton({
    Key? key,
    required bool hidden,
    required VoidCallback onPressed,
  })  : _hidden = hidden,
        _onPressed = onPressed,
        super(key: key);

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
