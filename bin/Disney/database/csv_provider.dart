import 'dart:io';

import 'package:csv/csv.dart';

import '../data/Info.dart';
import 'provider.dart';

class CsvProvider extends DataProvider<ListToCsvConverter, WaitingInfo> {
  List<List<dynamic>> rows = [];

  CsvProvider({ListToCsvConverter listToCsvConverter})
      : super(
          name: './data/disney.csv',
          dataClient: listToCsvConverter ?? ListToCsvConverter(),
        );

  @override
  Future<void> onInit() async {
    try{
      var file = File(name);
      var content = await file.readAsString();
      var rows = CsvToListConverter().convert(content);
      this.rows = rows;
    } catch(err){
      print('$err');
      return;
    }
  }

  @override
  Future<bool> writeSingle(data) async {
    try {
      var row = data.toCsvRow();
      rows.add(row.map((e) => e.value).toList());
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  @override
  Future<bool> writeMultiple(List<WaitingInfo> data) async {
    try {
      var willWriteHeader = rows.isEmpty;
      await super.writeMultiple(data);
      if (willWriteHeader) {
        rows = [
          if (data.isNotEmpty)
            data.first.toCsvRow().map((e) => e.variableName).toList(),
          ...rows
        ];
      }
      await dispose();
      return true;
    } catch (err) {
      print(err);
      return false;
    }


  }

  @override
  Future<void> dispose() async{
    var str = dataClient.convert(rows);
    var file = File(name);
    await file.writeAsString(str);

  }

}
