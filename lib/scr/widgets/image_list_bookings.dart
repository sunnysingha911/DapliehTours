import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:Daplieh/scr/models/bookings.dart';

class ImageBookings extends StatelessWidget {
  final String bookingName, source, destination, amount, tripName, bookingId, bimage;
  final BookingListItems book;
  ImageBookings({
    @required this.bookingName,
    @required this.source,
    @required this.destination,
    @required this.amount,
    @required this.tripName,
    @required this.bookingId,
    @required this.book,
    @required this.bimage
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 13.0,
              color: Colors.black.withOpacity(.1),
              offset: Offset(6.0, 7.0),
            ),
          ],
          shape: BoxShape.rectangle,
          //border: Border.all(),
          color: Colors.white,
        ),
        child: InkWell(
            onTap: (){
              print(1);
            },
            child: Row(
              children: <Widget>[
                Container(
                  child: Image.memory(base64Decode(bimage),height: 130,width: 130,fit: BoxFit.cover),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: 210,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Text("$bookingName",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black),textAlign: TextAlign.center,),
                        SizedBox(height: 10),
                        Text("$source",style: TextStyle(fontSize: 18,color: Colors.black),textAlign: TextAlign.center,),
                        Icon(Icons.arrow_forward,size: 20,color: Colors.green,),
                        Text("$destination",style: TextStyle(fontSize: 18,color: Colors.black),textAlign: TextAlign.center,),
                        SizedBox(height: 15),
                        Text("Rs. $amount",style: TextStyle(fontSize: 20,color: Colors.red,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                ),

              ],
            )
        ),
      ),
    );
  }
}


class ImageVehBooking extends StatelessWidget {
  final String modName, vehNo, type, amount, date, time, image, payMode, vehid;
  final BookingVehListItems book;
  ImageVehBooking({
    @required this.modName,
    @required this.vehNo,
    @required this.type,
    @required this.amount,
    @required this.date,
    @required this.time,
    @required this.image,
    @required this.payMode,
    @required this.vehid,
    @required this.book
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 13.0,
              color: Colors.black.withOpacity(.2),
              offset: Offset(6.0, 7.0),
            ),
          ],
          shape: BoxShape.rectangle,
          //border: Border.all(),
          color: Colors.white,
        ),
        child: InkWell(
            onTap: (){
              print(1);
            },
            child: Row(
              children: <Widget>[
                Container(
                  child: Image.memory(base64Decode(image),height: 100,width: 150,fit: BoxFit.cover),
                ),
                Column(
                  children: <Widget>[
                    Text("$modName",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black),textAlign: TextAlign.left),
                    SizedBox(height: 10),
                    Text("No: $vehNo  ",style: TextStyle(fontSize: 18,color: Colors.black),textAlign: TextAlign.center),
                    SizedBox(height: 15),
                    Text("Rs. $amount",style: TextStyle(fontSize: 20,color: Colors.red,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                  ],
                ),
              ],
            )
        ),
      ),
    );
  }
}