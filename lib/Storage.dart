// 입출력
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Storage{
  String? name;
  Storage(this.name);
  // 파일 위치 받기
  Future<String> get localPath async{
    var dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }
  // 파일 만들기
  Future<File> get localFile async{
    var path = await localPath;
    return File('$path/$name.txt');
  }
  // 파일 데이터 읽기
  Future<String> readData() async{
    try{
      var file = await localFile;
      String body = await file.readAsString();
      return body;
    } catch (e) {
      return '';
    }
  }
  // 파일에 데이터 쓰기
  Future<File> writeData(String data) async{
    var file = await localFile;
    return file.writeAsString("$data");
  }
}