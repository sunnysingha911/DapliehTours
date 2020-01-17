import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:Daplieh/scr/screens/BookingDetails.dart';
import 'package:Daplieh/scr/models/places.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';


class Details extends StatelessWidget {
  PlaceDetailListItem place;
  var format = DateFormat("dd-MM-yyyy HH:mm");
  var format2 = DateFormat("dd-MM-yyyy");
  Details(this.place);
  String _time,_date;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 300,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30),),
                  child: Image.memory(base64Decode(place.image), height: 400, width: double.infinity, fit: BoxFit.cover,),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.calendar_today, color: Colors.grey, size: 20,),
                      SizedBox(width: 5,),
                      Text('${place.duration}', style: TextStyle(color: Colors.grey))
                    ],
                  )
              ),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(8.0),
                  children: <Widget>[
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(text: '${place.tripName} \n', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black)),
                        TextSpan(text: '${place.info}')
                      ], style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black38)),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(8.0),
                  children: <Widget>[
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(text: 'Choose Date and Time \n', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black)),
                      ], style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey)),
                    ),
                    DateTimeField(
                    format: format,
                    onShowPicker: (context, currentValue) async {
                    final date = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100));
                    if (date != null) {
                    final time = await showTimePicker(
                    context: context,
                    initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                    );
                    _time=time.format(context);
                    _date=format2.format(date);
                    return DateTimeField.combine(date, time);
                    } else {
                    return currentValue;
                    }
                    },
                    ),
                  ],
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                    color: Colors.pink[400],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left:10),
                        child: RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(text: 'Price\n', style: TextStyle(fontSize: 18)),
                                TextSpan(text: '\Rs. ${place.cost}', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold))
                              ]
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right:20.0),
                        child: RaisedButton(
                          onPressed: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context) => BookDetails(place,_date,_time)),);
                          },
                          child: Text('Book a Tour'),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: 20,
            left: 10,
            child:  GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Align(
                alignment: Alignment.topLeft,
                child: Icon(Icons.arrow_back_ios),
              ),
            ),
          )
        ],
      ),
    );
  }
}