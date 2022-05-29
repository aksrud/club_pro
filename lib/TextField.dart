import 'package:flutter/material.dart';
import 'Storage.dart';
// 입출력
import 'dart:io';
import 'package:path_provider/path_provider.dart';

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
  // 파일 위치
  Future<Directory>? _appDocDir;

  // 파일 값을 가져오기
  @override
  void initState(){
    widget.storage.readData().then((String value){
      setState(() {
        state = value;
      });
    });
    super.initState();
  }

  // textfield값을 현재 값에 넣기
  Future<File> writeData() async{
  setState(() {
      state = controller.text;
    });
    return widget.storage.writeData(state!);
  }

  // 파일 위치 구하는 메서드
  void getAppDirectory(){
    setState(() {
      _appDocDir = getApplicationDocumentsDirectory();
    });
  }

  // textfield 표현
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextField(
            controller: controller,
            maxLines: 10,
          ),
        ]
      ),
    );
  }
}