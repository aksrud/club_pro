import 'package:flutter/material.dart';
// 메인 화면
import 'screen.dart';
// 위치 초기화
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return screen();
  }
}