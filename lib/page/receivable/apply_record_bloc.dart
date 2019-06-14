import 'package:flutter_architecture/arch/arch.dart';
import 'dart:async';
import 'package:flutter_architecture/base/repository.dart';

class ApplyRecordBloc {
  StreamController<Object> _streamController;
  Stream<Object> _stream;
  List<Object> _data;
  Repository repo;

  ApplyRecordBloc() {
    _data = [];
    _streamController = StreamController.broadcast();
    _stream = _streamController.stream;
    repo = Repository();
  }

  Stream<Object> get stream => _stream;

  List<Object> get data => _data;

  fetch() {
    _streamController.sink.add(repo.getProject());
  }

  dispose() {
    _streamController.close();
  }
}
