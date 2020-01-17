import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Daplieh/scr/models/bookings.dart';
import 'image_list_bookings.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:Daplieh/scr/models/source.dart';

class VBookingCards extends StatefulWidget {
  @override
  _VBookingCardsState createState() => _VBookingCardsState();
}

class _VBookingCardsState extends State<VBookingCards> {
  List<BookingVehListItems> listItems = [];
  @override
  void initState() {
    super.initState();
    FirebaseDatabase.instance.reference().child("Registration/$userId/Bookings/SelfRide").orderByKey().once().then((DataSnapshot snap){
      var keys = snap.value.keys;
      var data = snap.value;
      listItems.clear();
      for(var individualKey in keys){
        BookingVehListItems booking = new BookingVehListItems(
          data[individualKey]['ModelName'],
          data[individualKey]['VehicleNo'],
          data[individualKey]['VehicleType'],
          data[individualKey]['Amount'],
          data[individualKey]['Date'],
          data[individualKey]['Time'],
          data[individualKey]['Image'],
          data[individualKey]['PaymentMode'],
          data[individualKey]['id'],
        );
        listItems.add(booking);
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
        scrollDirection: Axis.vertical,
        itemCount: listItems.length,
        itemBuilder: (_, index) {
          return new ImageVehBooking(
            book: listItems[index],
            modName: listItems[index].modName,
            vehNo: listItems[index].vehNo,
            vehid: listItems[index].vehid,
            type: listItems[index].type,
            amount: listItems[index].amount,
            date: listItems[index].date,
            time: listItems[index].type,
            image: listItems[index].image,
            payMode: listItems[index].payMode,
          );
        }
      )
    );
  }
}

class BookingCards extends StatefulWidget {
  @override
  _BookingCardsState createState() => _BookingCardsState();
}

class _BookingCardsState extends State<BookingCards> {
  List<BookingListItems> listItems = [];
  @override
  void initState() {
    super.initState();
    FirebaseDatabase.instance.reference().child("Registration/$userId/Bookings/Trip").orderByChild('TimeStamp').once().then((DataSnapshot snap){
      var keys = snap.value.keys;
      var data = snap.value;
      listItems.clear();
      for(var individualKey in keys){
        BookingListItems booking = new BookingListItems(
          data[individualKey]['id'],
          data[individualKey]['TripName'],
          data[individualKey]['Source'],
          data[individualKey]['Destination'],
          data[individualKey]['PaymentMode'],
          data[individualKey]['Amount'],
          data[individualKey]['Image'],
        );
        listItems.add(booking);
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
        //reverse: true,
        scrollDirection: Axis.vertical,
        itemCount: listItems.length,
        itemBuilder: (_, index) {
          return new ImageBookings(
            book: listItems[index],
            bookingName: listItems[index].bookingName,
            amount: listItems[index].amount,
            tripName: listItems[index].bookingName,
            destination: listItems[index].destination,
            source: listItems[index].source,
            bookingId: listItems[index].bookingId,
            bimage: listItems[index].bimage,
          );
        }
      )
    );
  }
}
