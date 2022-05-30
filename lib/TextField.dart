import 'package:flutter/material.dart';
import 'SaveButton.dart';
import 'Storage.dart';

class TextFields extends StatefulWidget {
  final Storage storage;
  const TextFields({Key? key, required this.storage}) : super(key: key);

  @override
  State<TextFields> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  // textfield 값 받기
  TextEditingController controller = TextEditingController();
  // 현재 값
  String? state;

  // 파일 값을 가져오기
  @override
  void initState(){
    widget.storage.readData().then((String value){
      setState(() {
        state = value;
        controller.text=value;
      });
    });
    super.initState();
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
            storage: widget.storage,
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