/// G1 fixture — small member PR (direct push by ForinitTech).
library formatters;

String formatDuration(int seconds) {
  final m = seconds ~/ 60;
  final s = seconds % 60;
  return '${m}m ${s}s';
}

String formatScore(num score) {
  if (score >= 1000000) return '${(score / 1000000).toStringAsFixed(1)}M';
  if (score >= 1000) return '${(score / 1000).toStringAsFixed(1)}k';
  return score.toString();
}

String ordinal(int n) {
  final mod100 = n % 100;
  if (mod100 >= 11 && mod100 <= 13) return '${n}th';
  switch (n % 10) {
    case 1:
      return '${n}st';
    case 2:
      return '${n}nd';
    case 3:
      return '${n}rd';
    default:
      return '${n}th';
  }
}
