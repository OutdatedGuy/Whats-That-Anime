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
