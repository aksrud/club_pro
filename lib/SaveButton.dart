import 'package:flutter/material.dart';
// 파일에 데이터 저장
import 'Storage.dart';

class SaveButton extends StatefulWidget {
  final TextEditingController controller;
  final Storage storage;
  const SaveButton({Key? key, required this.controller, required this.storage}) : super(key: key);

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.save),
      onPressed: () {
        showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              content: Text("정보를 저장하시겠습니까?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("아니요")),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // 글을 저장
                    widget.storage.writeData(widget.controller.text);
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: Text("감정을 고르세요"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset("images/angry.png")),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset("images/angry.png")),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset("images/angry.png")),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
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
}