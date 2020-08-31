import 'package:disney_queue/disney_queue.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz;

void main(List<String> arguments) async {
  tz.initializeTimeZones();
  var shanghai = tz.getLocation('Asia/Shanghai');
  var now = tz.TZDateTime.now(shanghai);
  if (now.hour > 0 && now.hour < 24) {
    var shdl = ShangHaiDisneyLand();
    await shdl.writeToCSV();
  } else {
    print('Disney is not open');
  }
}
