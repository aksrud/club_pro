import 'package:flutter/material.dart';
// 세이브 버튼
import 'SaveButton.dart';
// 파일 입출력
import 'Storage.dart';

class TextFields extends StatefulWidget {
  const TextFields({Key? key}) : super(key: key);

  @override
  State<TextFields> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  
  // textfield 값 받기
  TextEditingController controller = TextEditingController();

  // 현재 값
  String? state;

  Storage storage_d = Storage("day");
  Storage storage = Storage("");

  // 파일 값을 가져오기
  @override
  void initState(){
    storage_d.readData().then((String a){
      setState(() {
        storage = Storage(a);
      });
      storage.readData().then((String value) {
        setState(() {
          state = value;
          controller.text=value;
        });
      },);
    });
    super.initState();
  }

  // 텍스트 필드 닫기
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  // textfield 표현
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // 저장 버튼
          SaveButton(
            controller: controller,
          ),
          // 글 쓰는 곳
          TextField(
            controller: controller,
            maxLines: 10,
          ),
        ]
      ),
    );
  }
}