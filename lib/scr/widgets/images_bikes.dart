import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Daplieh/scr/models/bikes.dart';
import 'package:firebase_database/firebase_database.dart';
import 'image_bike.dart';

class BikeImg extends StatefulWidget {
  @override
  _BikeImgState createState() => _BikeImgState();
}

class _BikeImgState extends State<BikeImg> {
  List<BikesDetailListItem> listBikes = [];
  @override
  void initState() {
    super.initState();
    FirebaseDatabase.instance.reference().child("Vehicle/Bike").orderByKey().once().then((DataSnapshot snap){
      var keys = snap.value.keys;
      var data = snap.value;
      listBikes.clear();
      for(var individualKey in keys){
        BikesDetailListItem bike = new BikesDetailListItem(
          data[individualKey]['Model'],
          data[individualKey]['Image'],
          data[individualKey]['CostPerHour'],
          data[individualKey]['CostPerDay'],
          data[individualKey]["ModelId"],
        );
        listBikes.add(bike);
      }
      setState(() {
        print('Length: $listBikes.length');
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listBikes.length,
            itemBuilder: (_, index) {
              return listBikes.length==0? new Text('No Data'):new BikeCard(
                bike: listBikes[index],
                model: listBikes[index].model,
                image: listBikes[index].image,
                costPday: listBikes[index].costPDay,
                costPhour: listBikes[index].costPHour,
                bid: listBikes[index].bId,
              );
            }));
  }
}
