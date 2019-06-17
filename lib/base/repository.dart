import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:rxdart/rxdart.dart';
import 'http_manager.dart';
import 'package:flutter_architecture/entity/entity_factory.dart';
import 'package:flutter_architecture/entity/entity.dart';

class Repository {
  static const String getPath = "/article/list/0/json";
  static const String tree = "/tree/json";
  static const String project = "/project/tree/json";

  Observable<T> loadFormAsset<T>(BuildContext context, String path) {
    return Observable.fromFuture(
            DefaultAssetBundle.of(context).loadString(path))
        .map((jsonStr) {
      return EntityFactory.generateOBJ<T>(json.decode(jsonStr));
    });
  }

  void fetch<M>() {
//    var future = HttpManager.getInstance().get(tree);
    var future = HttpManager.getInstance().getData(tree);
    Observable.fromFuture(future).doOnListen(() {
      print("doOnListen:");
    }).doOnData((onData) {
      var entity = EntityFactory.generateOBJ<StudyInfoEntity>(onData);
      print("doOnData: $entity");
    }).doOnError((error, stacktrace) {
      print("onError $error");
      print("onError $stacktrace");
    }).doOnDone(() {
      print("doOnDone:");
    }).listen(null);
  }

  Observable<Object> getReceivable() {
    return Observable.fromFuture(HttpManager.getInstance().get(tree))
        .map((jsonStr) {
      print("map: json = $jsonStr");
      return EntityFactory.generateOBJ<StudyInfoEntity>(jsonStr);
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

  Future<Object> getProject() async {
    var res = await HttpManager.getInstance().get(project);
    return EntityFactory.generateOBJ<StudyInfoEntity>(res);
  }
}
