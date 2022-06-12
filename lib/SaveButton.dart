import 'package:flutter/material.dart';

// 시간을 글로 바꾸기
import 'getday.dart';

// 파일에 데이터 저장
import 'Storage.dart';

class SaveButton extends StatefulWidget { 
  final TextEditingController controller;
  const SaveButton({Key? key, required this.controller}) : super(key: key);

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {

  // 선택한 날짜
  Storage day = Storage("day");

  // 선택한 날짜에 저장된 글
  Storage storage = Storage("");

  // 선택한 날짜에 저장된 아이콘
  Storage s_day = Storage("");

  @override
  void initState() {
    day.readData().then((String value){
      setState(() {
        storage = Storage(value);
        s_day = Storage("${value}_icon");
      });
    });
    super.initState();
  }
  // 데이터 저장
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
                                s_day.writeData("images/disappoint.png");
                              },
                              child: Image.asset("images/disappoint.png")),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(_);
                                s_day.writeData("images/happy.png");
                              },
                              child: Image.asset("images/happy.png")),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(_);
                                s_day.writeData("images/none.png");
                              },
                              child: Image.asset("images/none.png")),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(_);
                                s_day.writeData("images/sad.png");
                              },
                              child: Image.asset("images/sad.png")),
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
}

