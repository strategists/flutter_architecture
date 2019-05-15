import 'package:rxdart/rxdart.dart';
import 'http_manager.dart';

class Repository {
  static const String getPath = "/article/list/0/json";
  static const String tree = "/tree/json";

  void get<M>() {
//    Future<dynamic> future = HttpManager.getInstance().get(tree);
    /*future.asStream().listen((onData) {
      print("handleError: $onData");
    }).onError((handleError) {
      print("handleError: $handleError");
    });*/
    var observable = Observable.fromFuture(HttpManager.getInstance().get(tree));
    observable.doOnData((onData) {
      print("doOnData: $onData");
    }).doOnListen(() {
      print("doOnListen:");
    }).doOnError(() {
      print("doOnError:");
    }).doOnDone(() {
      print("doOnDone:");
    }).listen((onData) {
      print("listen: $onData");
    }, onError: () {
      print("onError:");
    }, onDone: () {
      print("onDone:");
    });
//    return observable;
  }
}
