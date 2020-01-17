import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Daplieh/scr/models/places.dart';
import 'package:firebase_database/firebase_database.dart';
import 'image_card.dart';

class ImageCards extends StatefulWidget {
  @override
  _ImageCardsState createState() => _ImageCardsState();
}

class _ImageCardsState extends State<ImageCards> {
  List<PlaceDetailListItem> listItems=[];
  @override
  void initState() {
    super.initState();
    FirebaseDatabase.instance.reference().child("Trip").once().then((DataSnapshot snap){
      var keys = snap.value.keys;
      var data = snap.value;
      listItems.clear();
      for(var individualKey in keys){
        PlaceDetailListItem place = new PlaceDetailListItem(
          data[individualKey]['TripName'],
          data[individualKey]['image'],
          data[individualKey]['Duration'],
          data[individualKey]['Destination'],
          data[individualKey]['Source'],
          data[individualKey]['Info'],
          data[individualKey]['Cost'],
        );
        listItems.add(place);

      }
      setState(() {
        print('Length: $listItems.length');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listItems.length,
            //itemExtent: 3,
            itemBuilder: (_, index) {
              return listItems.length==0? new Text('No Data'):new ImageCard(
                place: listItems[index],
                tripname: listItems[index].tripName,
                picture: listItems[index].image,
                duration: listItems[index].duration,
                destination: listItems[index].destination,
                source: listItems[index].source,
                info: listItems[index].info,
                cost: listItems[index].cost,
              );
            })
    );
  }
}


