// 날짜정보를 String 형식으로 바꿔줌
import 'package:intl/intl.dart';

// 시간을 구하는 함수
String getday(var day) {
  DateTime now = day;
  String formatter = DateFormat("yyyy.MM.dd").format(now);
  return formatter;
}