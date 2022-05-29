import 'package:flutter/material.dart';
import 'package:club_pro/Event.dart';
// 달력 라이브러리
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

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
            eventLoader: _getEventsfromDay,
          ),
          // 리스트 뷰
          ..._getEventsfromDay(selectedDay).map((Event event) => ListTile(
            leading: Image.asset(event.title),
            title: Text("aa"),
            onTap: (){},
            )
          )
        ],
      ),
      // float 버튼
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){Navigator.pop(context);},
        label: Text("go to write"),
      ),
    );
  }
  // 데이터 저장 형식
  late Map<DateTime, List<Event>> selectedEvents;

  //데이터 초기화(setstate라고 생각)
  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  // 이벤트 반환
  List<Event> _getEventsfromDay(DateTime day) {
    return selectedEvents[day] ?? [];
  }
}