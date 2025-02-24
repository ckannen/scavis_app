import 'dart:math';

class InterventionChartCreator {
  static const List<String> WEEKDAYS = ["So", "Mo", "Di", "Mi", "Do", "Fr", "Sa"];
  static const String LABEL_TODAY = "heute";

  // set the chart series data to last 7 days of data
  // This chart only works for 7 days.
  // if more days are required, not only the loop has to be changed, but also the way how to store the x-value in the series data
  // since otherwise the x with the same weekdays will be treated at the same time point
  static init7DayChart(dynamic resultData, String facet, int startDay) {
    List<dynamic> series = [];

    // get current timestamp to calculate weekday of today
    DateTime now = DateTime.now();

    try {
      // go through the last 8 days
      for (int i = 0; i < 8; i++) {
        // get the weekday of the day and show "today" instead of the weekday name, if the day is today
        String weekday = WEEKDAYS[(now.weekday - i) % 7];
        if (i == 0) weekday = LABEL_TODAY;

        // get the value for this day
        var value;
        dynamic dayEntry = resultData[(startDay - i).toString()];
        if (dayEntry != null && dayEntry[facet] != null && dayEntry[facet]["sum"] != null) {
          value = dayEntry[facet]["sum"];
        } else {
          value = 0;
        }

        // add an entry to the chart series data
        series.insert(0, {"x": weekday, "y": value});
      }
    } catch (e) {
      throw(e);
    }

    return series;
  }
}