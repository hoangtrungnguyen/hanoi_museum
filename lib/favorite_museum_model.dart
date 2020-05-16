import 'package:flutter/cupertino.dart';
import 'package:hanoimuseum/landing_page.dart';

class FavouriteModelMuseum extends ChangeNotifier{
  List<ItemMuseum> favourite = [];

  add(ItemMuseum itemMuseum){
    if(favourite.contains(itemMuseum)){
      return;
    }
    favourite.add(itemMuseum);
    itemMuseum.isFavourite = true;
    notifyListeners();
  }

}