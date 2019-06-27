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

  Observable<M> rxFetch<M>(String path, {Map params}) {
    var future = HttpManager.getInstance().getData(tree);
//    var future = Api.shared().get(path, params: params);
    return Observable.fromFuture(future).doOnListen(() {
      debugPrint("Repository doOnListen:");

      ///todo 开始请求接口时通用逻辑处理
    }).map((resObj) {
      debugPrint("Repository map: $resObj");
      return EntityFactory.generateOBJ<M>(resObj.data);
    }).doOnData((onData) {
      debugPrint("Repository doOnData: $onData");
    }).doOnError((error, stacktrace) {
      debugPrint("Repository error: $error \n $stacktrace");

      ///todo 通用错误处理
    }).doOnDone(() {
      debugPrint("Repository doOnDone:");

      ///todo 请求结束通用逻辑处理
    });
  }

  Future<M> fetch<M>(String path, {Map params}) async {
    var res = await HttpManager.getInstance().get(project);
    return EntityFactory.generateOBJ<M>(res);
  }
}
