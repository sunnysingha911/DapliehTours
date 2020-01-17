import 'package:flutter/material.dart';
import 'package:Daplieh/scr/models/bikes.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:Daplieh/scr/screens/vehicleBook.dart';
import 'package:firebase_database/firebase_database.dart';

class DetailBike extends StatefulWidget {
  final BikesDetailListItem bike;

  DetailBike(this.bike);
  @override
  _DetailBikeState createState() => _DetailBikeState(bike);
}

class _DetailBikeState extends State<DetailBike> {
  final BikesDetailListItem bike;
  _DetailBikeState(this.bike);

  var format = DateFormat("dd-MM-yyyy HH:mm");
  var format2 = DateFormat("dd-MM-yyyy");
  String _date,vehNo,_time,cost;
  int max=0,remain=0;
  int  _radioValue1=0;
  List<BikeNo> bike1 = [];
  setSelectedRadio(int val) {
    setState(() {
      _radioValue1 = val;
    });
  }

  @override
  void initState() {
    super.initState();
    FirebaseDatabase.instance.reference().child("Vehicle/Bike/${bike.bId}").orderByChild('Available').equalTo('Yes').once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key,values){
        if(values['Available'].toString()=='Yes'){
          vehNo = values['VehicleNo'];
        }
      });
      setState(() {
        print('Length ${values['VehicleNo']}');
      });
    });
  }

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
                  child: Image.memory(base64Decode(bike.image), height: 400, width: double.infinity, fit: BoxFit.cover,),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Row(
                    children: <Widget>[
                      SizedBox(width: 5,),
                    ],
                  )
              ),

              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(text: '${bike.model}\n', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.pink)),
                      ], style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey)),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(text: 'Cost Per 12 Hour: ', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black)),
                              //TextSpan(text: '$max \n', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black)),
                              TextSpan(text: 'Rs. ${bike.costPHour} \n', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300, color: Colors.black)),
                            ], style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            text: TextSpan(children: [

                            ], style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Radio(
                            value: 0,
                            activeColor: Colors.green,
                            groupValue: _radioValue1,
                            onChanged: (val){
                              setSelectedRadio(val);
                            },
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(text: 'Cost Per Day: ', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Colors.black)),
                              TextSpan(text: 'Rs. ${bike.costPDay} \n', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300, color: Colors.black)),
                            ], style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RichText(
                            text: TextSpan(children: [
                            ], style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Radio(
                            value: 1,
                            activeColor: Colors.green,
                            groupValue: _radioValue1,
                            onChanged: (val){
                              setSelectedRadio(val);
                            },
                          ),
                        ),

                      ],
                    ),

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
                          //h = time.hour as String;
                          //m = time.minute as String;
                          //_time = h + m;
                          print(_date);
                          print(_time);
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right:20.0),
                        child: RaisedButton(
                          onPressed: (){
                            Navigator.push(context,MaterialPageRoute(builder: (context) => BookDetailsVehicle(
                                vtype: "Bike",
                                model: bike.model,
                                vehicleno: vehNo,
                                cost: cost=_radioValue1==0?bike.costPHour:bike.costPDay,
                                time: _time,
                                date: _date,
                                vimage: bike.image
                            )),);
                          },
                          child: Text('Book Now'),
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

