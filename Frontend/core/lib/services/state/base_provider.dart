import 'package:flutter/cupertino.dart';

abstract class IBaseProvider<T> {
  T? get data;
  bool get loading;
  String? get error;

  void setData(T value);
  void setLoading(bool value);
  void setError(String value);
}

class BaseProvider<T> extends ChangeNotifier implements IBaseProvider {
  T? _data;
  bool _loading = false;
  String? _error;

  @override
  get data => _data;

  @override
  String? get error => _error;

  @override
  bool get loading => _loading;

  @override
  void setData(value) {
    _data = value;
    notifyListeners();
  }

  @override
  void setError(String value) {
    _error = value;
    notifyListeners();
  }

  @override
  void setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
