import 'package:flutter_architecture/arch/arch.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_architecture/base/repository.dart';

class ReceivableViewModel extends ViewModel {
  void fetch() {
    Repository().getReceivable().listen(null);
  }
}
