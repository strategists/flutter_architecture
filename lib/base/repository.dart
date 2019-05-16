import 'package:rxdart/rxdart.dart';
import 'http_manager.dart';

class Repository {
  static const String getPath = "/article/list/0/json";
  static const String tree = "/tree/json";

  void get<M>() {
    Observable.fromFuture(HttpManager.getInstance().get(tree)).doOnListen(() {
      print("doOnListen:");
    }).doOnData((onData) {
      print("doOnData: $onData");
    }).doOnError((error, stacktrace) {
      print("doOnError:");
    }).doOnDone(() {
      print("doOnDone:");
    }).listen(null);
  }
}
