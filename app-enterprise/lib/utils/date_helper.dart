import 'dart:io';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class DateHelper{
  String formattingDate(String oriDate, String? inputFormat, String output){
    DateFormat dateFormat;
    dateFormat = DateFormat(inputFormat ?? 'yyyy-MM-ddTHH:mm:ssZ', 'id_ID');

    DateTime dateTime = dateFormat.parse(oriDate);
    String formattedDate = DateFormat(output).format(dateTime);
    return formattedDate;
  }

  DateTime formattingDateIntoDateTime(String oriDate, String? inputFormat){
    DateFormat dateFormat;
    dateFormat = DateFormat(inputFormat ?? 'yyyy-MM-ddTHH:mm:ssZ', 'id_ID');

    DateTime dateTime = dateFormat.parse(oriDate);
    return dateTime;
  }

  String converTimestampIntoFormattedDate({required int timestamp, String? outFormat}){
    var dt = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var date = "";

    date = DateFormat(outFormat ?? 'dd/MM/yyyy').format(dt);
    return date;
  }

  int convertDateFormatIntoTimestamp(String inFormat, String date) {
    // initializeDateFormatting();

    DateTime parseDate = DateFormat(inFormat).parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    return inputDate.millisecondsSinceEpoch;
  }

  int getCurrentTimestamp() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  String getCurrentFormatedTime(String format) {
    var now = DateTime.now();
    var formatter = DateFormat(format);
    String formattedDate = formatter.format(now);
    return formattedDate;
  }
}