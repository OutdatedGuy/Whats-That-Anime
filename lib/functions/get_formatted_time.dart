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

/// Converts given seconds to a string of human-readable time.
String getFormattedDuration(int totalSeconds) {
  final Duration duration = Duration(seconds: totalSeconds);
  final int seconds = totalSeconds % 60;
  int minutes = duration.inMinutes;
  int hours = duration.inHours;

  String time = '';
  if (hours > 0) {
    time += '${hours.toString().padLeft(2, '0')}:';
    minutes %= 60;
  }
  if (minutes > 0) {
    time += '${minutes.toString().padLeft(2, '0')}:';
  }
  time += seconds.toString().padLeft(2, '0')..trim();

  return time;
}
