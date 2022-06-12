import 'package:flutter/material.dart';
// 달력있는 부분 소스코드
import 'Calendar.dart';
// 저장 버튼
import 'SaveButton.dart';
// 파일 입출력
import 'Storage.dart';
// 글자 입력 하는 곳
import 'TextField.dart';

class screen extends StatefulWidget {
  const screen({ Key? key }) : super(key: key);

  @override
  State<screen> createState() => screenState();
}

class screenState extends State<screen> {
  // 선택한 시간
  String? day;
  Storage storage = Storage("day");

  // 시간 불러오기 
  @override
  void initState(){
    storage.readData().then((String value){
      setState(() {
        day = value;
        storage.writeData("$day");
      });
    });
    super.initState();
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
        backgroundColor: Color.fromRGBO(220, 235, 255, 1),

        // 앱 바 부분
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromRGBO(218, 203, 227, 1),
          elevation: 0,

          // 현재 시간을 구하는 함수를 호출, 반환해 Text로 만듬
          title: Text("$day", 
            style: TextStyle(color: Color.fromRGBO(173, 140, 191, 1)),
          ),

          // 앱 바 왼쪽 부분
          leading: Builder(
            builder: (context) {

              // 아이콘 버튼을 누름면 달력 화면으로 이동
              return IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: ((context) => Calendar())));
                }
               );
            }
          ),
        ),

        // 입력 하는 곳
        body: TextFields(),
      ),
    );
  }
}