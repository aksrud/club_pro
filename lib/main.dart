import 'package:club_pro/Storage.dart';
import 'package:club_pro/TextField.dart';
import 'package:flutter/material.dart';
// 날짜정보를 String 형식으로 바꿔줌
import 'package:intl/intl.dart';
// 달력을 한글화함
import 'package:intl/date_symbol_data_local.dart';
// 디스크에 현재 날 저장
import 'package:shared_preferences/shared_preferences.dart';
// 달력있는 부분 소스코드
import 'Calendar.dart';
// 저장 버튼
import 'SaveButton.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 목표시간
  DateTime? day;
  SharedPreferences? pre;

  // 목표시간 로드 불러오기 
  @override
  void initState(){
    super.initState();
    loadDay();
  }

  // 목표시간 로드 
  loadDay() async{
    pre = await SharedPreferences.getInstance();
    setState(() {
      day = (pre?.get('Day') ?? DateTime.now()) as DateTime?;
    });
  }

  @override
  Widget build(BuildContext context) {

    // Material 디자인으로 만듬
    return MaterialApp(
      // 오른쪽 디버그 막대 없애기
      debugShowCheckedModeBanner: false,
      // 앱이 처음 실행 될때 뜨는 컨테이너 추가
      home: Scaffold(
        // 배경
        backgroundColor: Color.fromRGBO(230, 244, 253, 1),
        // 앱 바 부분
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(218, 203, 227, 1),
          elevation: 0,
          // 현재 시간을 구하는 함수를 호출, 반환해 Text로 만듬
          title: Text("${getday(day)}", 
            style: TextStyle(color: Color.fromRGBO(173, 140, 191, 1)),
          ),
          // 앱 바 왼쪽 부분
          leading: Builder(
            builder: (context) {
              // 아이콘 버튼을 누름면 달력 화면으로 이동
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => Calendar()));
                }
               );
            }
          ),
        ),
        // 입력 구간
        body: TextFields(storage: Storage(getday(day)),),
      ),
    );
  }
}

// 시간을 구하는 함수
String getday(var day) {
  DateTime now = day;
  String formatter = DateFormat("yyyy-MM-dd").format(now);
  return formatter;
}