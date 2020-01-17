import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Daplieh/scr/models/cars.dart';
import 'package:firebase_database/firebase_database.dart';
import 'image_car.dart';

class CarImg extends StatefulWidget {
  @override
  _CarImgState createState() => _CarImgState();
}

class _CarImgState extends State<CarImg> {
  List<CarsDetailListItem> listCars = [];
  @override
  void initState() {
    super.initState();
    FirebaseDatabase.instance.reference().child("Vehicle/Car").once().then((DataSnapshot snap){
      var keys = snap.value.keys;
      var data = snap.value;
      listCars.clear();
      for(var individualKey in keys){
        CarsDetailListItem car = new CarsDetailListItem(
          data[individualKey]['Model'],
          data[individualKey]['Image'],
          data[individualKey]['CostPerHour'],
          data[individualKey]['CostPerDay'],
          data[individualKey]["ModelId"],
        );
        listCars.add(car);
      }
      setState(() {
        print('Length: $listCars.length');
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listCars.length,
            itemBuilder: (_, index) {
              return listCars.length==0? new Text('No Data'):new CarCard(
                car: listCars[index],
                model: listCars[index].model,
                image: listCars[index].image,
                costPday: listCars[index].costPday,
                costPhour: listCars[index].costPhour,
                cid: listCars[index].cid,
              );
            }));
  }
}
