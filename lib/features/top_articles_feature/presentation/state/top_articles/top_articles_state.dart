import 'package:flutter/material.dart';

enum TopArticlesStateEnum {
  loading,
  empty,
  loaded,
  error,
}

class TopArticlesState extends ChangeNotifier {
  TopArticlesStateEnum pageState = TopArticlesStateEnum.loading;

  void updatePageState(TopArticlesStateEnum state) {
    pageState = state;
    notifyListeners();
  }
}