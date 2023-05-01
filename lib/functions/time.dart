// Convert TimeOfDay to string
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String timeOfDayToString(TimeOfDay time) {
  final now = DateTime.now();
  final dateTime =
      DateTime(now.year, now.month, now.day, time.hour, time.minute);
  final formatter = DateFormat('h:mm a');
  return formatter.format(dateTime);
}

// Convert string to TimeOfDay
TimeOfDay stringToTimeOfDay(String timeString) {
  final formatter = DateFormat('h:mm a');
  final dateTime = formatter.parse(timeString);
  return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
}

String formatTime(int hour, int minute) {
  final period = hour < 12 ? 'AM' : 'PM';
  final hourString = (hour % 12).toString().padLeft(2, '0');
  final minuteString = minute.toString().padLeft(2, '0');
  return '$hourString:$minuteString $period';
}
