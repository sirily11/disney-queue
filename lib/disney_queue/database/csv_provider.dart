import 'dart:io';

import 'package:csv/csv.dart';

import '../data/Info.dart';
import 'provider.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

class CsvProvider extends DataProvider<ListToCsvConverter, WaitingInfo> {
  List<List<dynamic>> rows = [];
  bool willWriteHeader = false;

  CsvProvider({ListToCsvConverter listToCsvConverter})
      : super(
          name: './data/disney.csv',
          dataClient: listToCsvConverter ?? ListToCsvConverter(),
        );

  @override
  Future<void> onInit() async {
    try {
      var file = File(name);
      var content = await file.readAsString();
      var rows = CsvToListConverter().convert(content);
      this.rows = rows;
      willWriteHeader = rows.isEmpty;
    } on FileSystemException catch (err) {
      print('Create file');
      willWriteHeader = true;
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
      await super.writeMultiple(data);
      if (willWriteHeader) {
        rows = [
          if (data.isNotEmpty)
            data.first.toCsvRow().map((e) => e.variableName.capitalize()).toList(),
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
  Future<void> dispose() async {
    var str = dataClient.convert(rows);
    var file = File(name);
    await file.writeAsString(str);
  }
}
