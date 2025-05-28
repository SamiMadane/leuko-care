
import 'package:easy_localization/easy_localization.dart';

String formatTimestampWithElapsed(DateTime time) {
  final now = DateTime.now();
  final diff = now.difference(time);
  String elapsed;

  if (diff.inDays > 7) {
    elapsed = '${time.day}/${time.month}/${time.year}';
  } else if (diff.inDays >= 1) {
    elapsed = plural(
      'time_ago_days',
      diff.inDays,
      namedArgs: {'count': diff.inDays.toString()},
    );
  } else if (diff.inHours >= 1) {
    elapsed = plural(
      'time_ago_hours',
      diff.inHours,
      namedArgs: {'count': diff.inHours.toString()},
    );
  } else if (diff.inMinutes >= 1) {
    elapsed = plural(
      'time_ago_minutes',
      diff.inMinutes,
      namedArgs: {'count': diff.inMinutes.toString()},
    );
  } else {
    elapsed = 'now'.tr();
  }

  final clock = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  return '$elapsed • $clock';
}
