import 'package:meta/meta.dart';

abstract class DataProvider<V, T> {
  final V dataClient;
  final String name;

  DataProvider({@required this.dataClient, @required this.name});

  /// Init Data provider
  Future<void> onInit();

  /// Write Single.
  Future<bool> writeSingle(T data);

  /// Write Multiple.
  Future<bool> writeMultiple(List<T> data) async {
    try {
      await onInit();
      for (var d in data) {
        await writeSingle(d);
      }
      return true;
    } catch (err) {
      print(err);
      return false;
    }
  }

  Future<void> dispose() async{

  }
}
