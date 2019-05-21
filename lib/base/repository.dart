import 'package:rxdart/rxdart.dart';
import 'http_manager.dart';
import 'package:flutter_architecture/entity_factory.dart';
import 'dart:convert';
import 'package:flutter_architecture/entity/study_info_entity.dart';


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

  Observable<Object> getReceivable() {
    return Observable.fromFuture(HttpManager.getInstance().get(tree))
        .map((jsonStr) {
      print("map: json = $jsonStr");
      return EntityFactory.generateOBJ<StudyInfoEntity>(json.decode(jsonStr));
    }).doOnListen(() {
      print("doOnListen:");
    }).doOnData((onData) {
      print("doOnData: $onData");
    }).doOnError((error, stacktrace) {
      print("doOnError:");
    }).doOnDone(() {
      print("doOnDone:");
    });
  }
}
