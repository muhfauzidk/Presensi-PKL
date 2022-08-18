import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ntp/ntp.dart';

Future<bool> isCheckInTime() async {
  int startTime = 7;
  int endTime = 9;

  DateTime ntpTime = await NTP.now();
  int currentTime = ntpTime.hour;

  return currentTime >= startTime && currentTime <= endTime;
}

Future<bool> isCheckOutTime() async {
  int startTime = 15;
  int endTime = 18;

  DateTime ntpTime = await NTP.now();
  int currentTime = ntpTime.hour;

  return currentTime >= startTime && currentTime <= endTime;
}

String getSystemTime() {
  DateTime currenTime = DateTime.now();

  return DateFormat('HH : mm : ss').format(currenTime);
}

Future<DateTime?> pickDate(BuildContext context) async {
  DateTime currentDate = DateTime.now();

  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: currentDate,
    currentDate: currentDate,
    firstDate: currentDate.subtract(const Duration(days: 365)),
    lastDate: currentDate.add(const Duration(days: 365)),
  );

  return pickedDate;
}
