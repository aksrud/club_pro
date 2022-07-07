import 'package:flutter/material.dart';

// 이벤트 객체
import 'Event.dart';

// 달력 라이브러리
import 'package:table_calendar/table_calendar.dart';

// 파일 입출력
import 'Storage.dart';

// 메인 화면
import 'main.dart';

// 시간을 글로 바꾸기
import 'getday.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  // 달력 형식
  CalendarFormat format = CalendarFormat.month;
  // 선택한 날짜
  DateTime selectedDay = DateTime.now();
  // 현재 목표 날짜
  DateTime focusedDay = DateTime.now();
  // 현재 선택한 날짜 저장
  Storage storage = Storage("day");
  // 아이콘 불러오는 곳
  Storage emotion = Storage("");

  // 데이터 저장 형식
  Map<String, List<Event>> selectedEvents = {};

  //데이터 초기화
  @override
  void initState() {
    nogada();
    storage.readData().then((String value){
      setState(() {
        DateTime time = DateTime(
          int.parse(value.substring(0, 4)),
          int.parse(value.substring(5, 7)),
          int.parse(value.substring(8, 10)),
        );
        focusedDay = time;
      });
    });
    super.initState();
  }
  
  void event_add(String day){
    String icon = "";
    emotion = Storage("${day}_icon");
    emotion.readData().then((String a){
      if(a ==""){
        return;
      }
      setState(() {
        icon = a;
        selectedEvents[day] = [
          Event(name: icon),
        ];
      });
    });
    setState(() {});
  }

  // 이벤트 반환
  List<Event> _getEventsfromDay(String day) {
    return selectedEvents[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {

    // Scaffold로 반환
    return Scaffold(
      // 달력 생성
      body: Column(
        children: [
          TableCalendar(
            // 현재 목표 설정
            focusedDay: focusedDay,
            // 처음 날짜 설정
            firstDay: DateTime(2022, 1, 1),
            //마지막 날짜 설정
            lastDay: DateTime(2022, 12, 31),
            // 현재 위치
            locale: 'ko-KR',
            //주가 시작되는 요일
            startingDayOfWeek: StartingDayOfWeek.monday,

            // 날짜 선택
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                selectedDay = selectDay;
                focusedDay = focusDay;
                storage.writeData("${getday(selectDay)}");
              });
            },
            selectedDayPredicate: (DateTime day) {
              return isSameDay(selectedDay, day);
            },

            // 달력 형태
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },

            // 달력 표현
            calendarStyle: const CalendarStyle(
              isTodayHighlighted: true,
              todayDecoration:
                  BoxDecoration(color: Colors.purple, shape: BoxShape.circle),
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),

            // 위쪽에 있는 요소 속성 바꾸기
            headerStyle: const HeaderStyle(
              titleCentered: true,
              formatButtonShowsNext: false,
            ),

            // 이벤트 처리
            eventLoader: (day) {
              return _getEventsfromDay(getday(day));
            },
          ),
          // 리스트 뷰
          ..._getEventsfromDay(getday(selectedDay)).map((Event event) => ListTile(leading: Image.asset(event.name),)),
        ],
      ),
      // float 버튼
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: ((context) => Screen())));
        },
        label: Text("go to write"),
      ),
    );
  }

  void nogada(){
    for(int i=1; i<=12; i++){
      if(i==4||i==6||i==9||i==11){
        for(int j=1; j<=30; j++){
          event_add(getday(DateTime(2022, i, j)));
        }
      } else if(i==2){
        for(int j=1; j<=28; j++){
          event_add(getday(DateTime(2022, i, j)));
        }
      } else{
        for(int j=1; j<=31; j++){
          event_add(getday(DateTime(2022, i, j)));
        }
      }
    }
  }
}