import 'dart:async';
import 'package:provide/provide.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ViewModel with ChangeNotifier {
  CompositeSubscription compositeSubscription = CompositeSubscription();

  /// add [StreamSubscription] to [compositeSubscription]
  /// 在 [dispose]的时候能进行取消
  addSubscription(StreamSubscription subscription) {
    compositeSubscription.add(subscription);
  }

  @override
  void dispose() {
    super.dispose();
    compositeSubscription.dispose();
  }
}

abstract class PageProviderNode extends StatelessWidget {
  final Providers providers = new Providers();

  Widget buildPage(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return ProviderNode(
      providers: providers,
      child: buildPage(context),
    );
  }
}
