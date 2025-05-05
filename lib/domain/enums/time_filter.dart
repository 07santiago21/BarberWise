enum TimeFilter {
  last7Days,
  last15Days,
  last30Days,
}

extension TimeFilterExtension on TimeFilter {
  int get days {
    switch (this) {
      case TimeFilter.last7Days:
        return 7;
      case TimeFilter.last15Days:
        return 15;
      case TimeFilter.last30Days:
        return 30;
    }
  }

  String get displayName {
    switch (this) {
      case TimeFilter.last7Days:
        return '7 días';
      case TimeFilter.last15Days:
        return '15 días';
      case TimeFilter.last30Days:
        return '30 días';
    }
  }

  DateTime get startDate => DateTime.now().subtract(Duration(days: days - 1));
}
