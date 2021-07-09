abstract class Codable {
  T decode<T>(Coder coder);
  Map<String, dynamic> encode();
}

abstract class Coder<T extends Codable> {
  T decode(Map<String, dynamic> json);
  Map<String, dynamic> encode(T obj);
}

class JsonCoder<T extends Codable> implements Coder<T> {
  @override
  T decode(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> encode(T obj) {
    return obj.encode();
  }
}