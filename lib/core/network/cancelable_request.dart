abstract class Cancelable {
  void cancel();
}

abstract class Request implements Cancelable {}