import 'Disney/shanghaiDisney.dart';

void main(List<String> arguments) async {
  var shdl = ShangHaiDisneyLand();
  var resp = await shdl.getWaitingTime();
  print(resp);
}
