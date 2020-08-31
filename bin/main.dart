import 'dart:mirrors';

import 'Disney/data/Info.dart';
import 'Disney/shanghaiDisney.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;




void main(List<String> arguments) async {
  tz.initializeTimeZones();
  var shanghai = tz.getLocation('Asia/Shanghai');
  var now = tz.TZDateTime.now(shanghai);
  if(now.hour > 7 && now.hour < 22){
    var shdl = ShangHaiDisneyLand();
    // await shdl.writeToCSV();
    var token = await shdl.getAuthorizationToken();
    print(token);
  } else{
    print('Disney is not open');
  }
}
