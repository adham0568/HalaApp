import 'package:flutter/material.dart';
class Ordars with ChangeNotifier{

  converttoMap({required var snapshot}){
    List<Map<String, dynamic>> myList = [];

    for (var item in snapshot.data()) {
      Map<String, dynamic> itemMap = {
        'IdCollection': item['IdCollection'],
        'IdMainCollection': item['IdMainCollection'],
        'IdPrudact': item['IdPrudact'],
        'ImageUrl': item['ImageUrl'],
        'Name': item['Name'],
        'Prise': item['Prise'],
        'PrudactsDetals': item['PrudactsDetals'],
      };
      myList.add(itemMap);
    }

    print(myList);
  }


  List<Map> Products = [];

  GetNumberByProducts(Map item) {
    int Numproducts = 0;
    for (int i = 0; i < Products.length; i++) {
      if (Products[i]['IdPrudact'] == item['IdPrudact']) {
        Numproducts++;
      }
    }
    return Numproducts;
  }

}