import 'package:Car_service/tools/constants.dart';
import 'package:flutter/material.dart';

import '../model/Item.dart';
import 'ItemList.dart';

class PartScreen extends StatelessWidget {
  late List<Item> itemList;
  String phone1 = "0792281812"; //مركز النشاش
  String marker1 = "32.0967382,36.1089721";
  String phone2 = "0795530759"; //مركز زعتر
  String marker2 = "32.0891173,36.1081806";
  String phone3 = "0795530759"; //مركز ابو
  String marker3 = " 32.0954904,36.1093087";
  String phone4 = "0788724660"; //مركز العبسي
  String marker4 = "32.0969443,36.127042";

  @override
  Widget build(BuildContext context) {
    itemList = _itemList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Part Shops'),
        centerTitle: true,
        backgroundColor: primecolor,
      ),
      body: _listView(),
    );
  }

  Widget _listView() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Expanded(
              child: ListView(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            children: itemList
                .map(
                  (Item) => ItemList(item: Item),
                )
                .toList(),
          )),
        ],
      ),
    );
  }

  List<Item> _itemList() {
    return [
      Item(
        id: 0,
        name: 'مركز النشاش لقطع غيار السيارات',
        category: ' قطع هايبرد و كهرباء ',
        rating: 3.9,
        imageUrl: 'assets/images/nah.jpg',
      ),
      Item(
        id: 1,
        name: 'زعتر لقطع غيار السيارات ',
        category: 'قطع سيارات كوري',
        rating: 4.4,
        imageUrl: 'assets/images/za3ter.jpg',
      ),
      Item(
        id: 2,
        name: 'محل ابو اصبع لقطع غيار السيارات',
        category: "قطع هايبرد و بنزين",
        rating: 5.0,
        imageUrl: 'assets/images/abo.jpg',
      ),
      Item(
        id: 3,
        name: 'العبسي لقطع غيار السيارات ',
        category: 'قطع غيار ديزل ',
        rating: 5.0,
        imageUrl: 'assets/images/3bsi.jpg',
      ),
    ];
  }
}
