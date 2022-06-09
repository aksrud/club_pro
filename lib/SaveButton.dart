import 'package:flutter/material.dart';
// 파일에 데이터 저장
import 'Storage.dart';
// 날짜정보를 String 형식으로 바꿔줌
import 'package:intl/intl.dart';

class SaveButton extends StatefulWidget { 
  final TextEditingController controller;
  const SaveButton({Key? key, required this.controller}) : super(key: key);

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  Storage day = Storage("day");
  Storage storage = Storage("");
  Storage s_day = Storage("");

  @override
  void initState() {
    day.readData().then((String value){
      String a = "";
      if (value == ""){
        setState(() {
          a = getday(DateTime.now());
          storage = Storage(a);
          s_day = Storage("${a}_icon");
        });
      }
      else {
        setState(() {
          storage = Storage(value);
          s_day = Storage("${value}_icon");
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext ctx) {
    return IconButton(
      icon: Icon(Icons.save),
      onPressed: () {
        showDialog(
          context: ctx,
          builder: (_) {
            return AlertDialog(
              content: Text("정보를 저장하시겠습니까?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(_);
                  },
                  child: Text("아니요")),
                TextButton(
                  onPressed: () {
                    Navigator.pop(_);
                    
                    // 글을 저장
                    storage.writeData(widget.controller.text);
                    showDialog(
                      context: ctx,
                      builder: (_) {
                        return AlertDialog(
                          title: Text("감정을 고르세요"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(_);
                                s_day.writeData("images/angry.png");
                              },
                              child: Image.asset("images/angry.png")),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(_);
                                s_day.writeData("images/angry.png");
                              },
                              child: Image.asset("images/angry.png")),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(_);
                                s_day.writeData("images/angry.png");
                              },
                              child: Image.asset("images/angry.png")),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(_);
                                s_day.writeData("images/angry.png");
                              },
                              child: Image.asset("images/angry.png")),
                          ],
                        );
                      }
                    );
                  },
                  child: Text("네")
                ),
              ],
            );
          },
        );
      }
    );
  }
  // 시간을 구하는 함수
  String getday(var day) {
    DateTime now = day;
    String formatter = DateFormat("yyyy.MM.dd").format(now);
    return formatter;
  }
}

