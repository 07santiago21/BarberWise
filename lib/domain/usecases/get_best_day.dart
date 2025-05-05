import 'package:intl/intl.dart';
import '../entities/appointments.dart';
import '../enums/time_filter.dart';

class GetBestDay {
  String call(List<Appointments> appointments, TimeFilter filter) {
    if (appointments.isEmpty) return '';

    final from = filter.startDate;
    final to = DateTime.now();
    final totalDays = to.difference(from).inDays + 1;
    final groupByWeek = filter == TimeFilter.last30Days;
    final bucketCount = groupByWeek ? 4 : totalDays;

    final counts = <int, int>{};
    for (var a in appointments) {
      final svcCount = a.services.length;
      if (svcCount == 0) continue;
      final diff = a.startTime.difference(from).inDays;
      final bucket = groupByWeek ? (diff * bucketCount ~/ totalDays) : diff;
      counts[bucket] = (counts[bucket] ?? 0) + svcCount;
    }
    if (counts.isEmpty) return '';

    final bestBucket = counts.entries
        .reduce((a, b) => a.value > b.value ? a : (a.value < b.value ? b : a))
        .key;

    DateTime bestDate;
    if (groupByWeek) {
      final span = totalDays / bucketCount;
      final startOff = (bestBucket * span).floor();
      final endOff = ((bestBucket + 1) * span).ceil() - 1;
      bestDate = from.add(Duration(days: (startOff + endOff) ~/ 2));
    } else {
      bestDate = from.add(Duration(days: bestBucket));
    }

    final locale = 'es';
    final weekday = DateFormat('EEEE', locale).format(bestDate).toLowerCase();
    final day = bestDate.day;
    final month = DateFormat('MMMM', locale).format(bestDate).toLowerCase();
    return '$weekday $day de $month';
  }
}
