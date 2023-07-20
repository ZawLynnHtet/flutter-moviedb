import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  List<String> _favoriteList = [];
  List<String> get favorite => _favoriteList;

  void toggleFavorite(String fav){
    final isExist = _favoriteList.contains(fav);
    if(isExist){
      _favoriteList.remove(fav);
    }else {
      _favoriteList.add(fav);
    }
    notifyListeners();
  }

  bool isExist(String fav){
    final isExist = _favoriteList.contains(fav);
    return isExist;
  }

  void clearFavorite(){
    _favoriteList = [];
    notifyListeners();
  }
}