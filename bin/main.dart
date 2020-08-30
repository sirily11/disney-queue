import 'dart:mirrors';

import 'Disney/data/Info.dart';
import 'Disney/shanghaiDisney.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;




void main(List<String> arguments) async {
  tz.initializeTimeZones();
  var shanghai = await tz.getLocation('Asia/Shanghai');
  var now = tz.TZDateTime.now(shanghai);
  print(now);
  // var shdl = ShangHaiDisneyLand();
  // await shdl.writeToCSV();
}
