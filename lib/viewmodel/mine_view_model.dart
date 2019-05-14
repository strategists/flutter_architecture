import 'package:flutter_architecture/arch/arch.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_architecture/entity/profile_entity.dart';
import 'package:flutter_architecture/entity/entity_factory.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class MineViewModel extends ViewModel {
  List<PreferenceItem> _items = [];

  get items => _items;

  void loadProfile(BuildContext context) {
    debugPrint("MineViewModel $context");
    Future<String> loadString =
        DefaultAssetBundle.of(context).loadString("assets/profile.json");

    loadString.then((onValue) => Future.value(onValue));

    //create observable
    var observable = Observable.fromFuture(
            DefaultAssetBundle.of(context).loadString("assets/profile.json"))
        .delay(Duration(milliseconds: 500))
        .asBroadcastStream();

    observable.doOnData((onData) {
      print(onData);
      var profileEntity = EntityFactory.generateOBJ<ProfileEntity>(onData);
      _items.addAll(profileEntity.data);
      _items.forEach((f) => debugPrint("profile $f"));
    }).doOnError(() {
      debugPrint("error");
    }).doOnListen(() {
      print("doOnListen");
    }).doOnDone(() {
      print("doOnDone");
    });
  }


}
