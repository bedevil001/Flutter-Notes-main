import 'package:flutter/foundation.dart';

class SearchQuery with ChangeNotifier {
  String _query = "";

  String get query => _query;

  set query(String query) {
    _query = query;
  }

  void changeQuery(String query){
    _query = query;
    notifyListeners();
  }
}
