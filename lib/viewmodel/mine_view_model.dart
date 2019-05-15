import 'package:flutter_architecture/arch/arch.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_architecture/entity/profile_entity.dart';
import 'package:flutter_architecture/entity/entity_factory.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/base/repository.dart';

typedef HandError = void Function();

class MineViewModel extends ViewModel {
  List<PreferenceItem> _items = [];

  Repository _repo = new Repository();

  get items => _items;

  void loadProfile(BuildContext context) {
    debugPrint("MineViewModel $context");
    Future<String> loadString =
        DefaultAssetBundle.of(context).loadString("assets/profile.json");

    loadString.asStream().listen(
      (onData) {
        print("onData");
        var profileEntity =
            EntityFactory.generateOBJ<ProfileEntity>(json.decode(onData));
        _items.addAll(profileEntity.data);
        _items.forEach((f) => debugPrint("profile $f"));
        notifyListeners();
      },
      onDone: () {
        print("onDone");
      },
    );

    //create observable
    /*var observable = Observable.fromFuture(
            DefaultAssetBundle.of(context).loadString("assets/profile.json"))
        .delay(Duration(milliseconds: 500))
        .asBroadcastStream();

    observable.doOnData((onData) {
      print("doOnData");
      var profileEntity = EntityFactory.generateOBJ<ProfileEntity>(json.decode(onData));
      _items.addAll(profileEntity.data);
      _items.forEach((f) => debugPrint("profile $f"));
      notifyListeners();
    }).doOnError(() {
      debugPrint("error");
    }).doOnListen(() {
      print("doOnListen");
    }).doOnDone(() {
      print("doOnDone");
    }).listen((onData){
      print("listen onData");
    },onDone: (){
      print("listen onDone");
    },cancelOnError: false);*/
  }

  void fetch() {
    _repo.get();
  }
}
