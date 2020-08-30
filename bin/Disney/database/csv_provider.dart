import 'dart:io';

import 'package:csv/csv.dart';

import '../data/Info.dart';
import 'provider.dart';



class CsvProvider extends DataProvider<ListToCsvConverter, WaitingInfo> {
  List<List<String>> rows = [];
  
  CsvProvider({ListToCsvConverter listToCsvConverter})
      : super(
          name: 'data/disney.csv',
          dataClient: listToCsvConverter ?? ListToCsvConverter(),
        );

  @override
  Future<void> onInit() async {
    var file = File(name);
    var content = await file.readAsString();
    var rows = CsvToListConverter().convert(content);
    this.rows = rows;
  }

  @override
  Future<bool> writeSingle(data) async{
    try{
      var c = this.dataClient.convert([]);
      return true;
    } catch(err){
      print(err);
      return false;
    }
  }
}
