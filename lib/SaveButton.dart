import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({Key? key}) : super(key: key);

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