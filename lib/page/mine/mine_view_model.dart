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
    _repo.loadFormAsset<ProfileEntity>(context, "assets/profile.json").listen(
          (onData) {
            _items.addAll(onData.data);
            notifyListeners();
          },
          onDone: () {},
          onError: (error, stacktrace) {
            print("onError $error");
            print("onError $stacktrace");
          },
        );
    /*DefaultAssetBundle.of(context)
        .loadString("assets/profile.json")
        .asStream()
        .listen((onData) {
      print("onData");
      var profileEntity =
          EntityFactory.generateOBJ<ProfileEntity>(json.decode(onData));
      _items.addAll(profileEntity.data);
      _items.forEach((f) => debugPrint("profile $f"));
      notifyListeners();
    }, onDone: () {
      print("onDone");
    }, onError: (error, stacktrace) {
      print("onError $error");
      print("onError $stacktrace");
    });*/
  }

  void fetch() {
    _repo.fetch();
  }
}
