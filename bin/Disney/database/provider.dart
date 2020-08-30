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
      for (var d in data) {
        await writeSingle(d);
      }
      return true;
    } catch (err) {
      return false;
    }
  }
}
