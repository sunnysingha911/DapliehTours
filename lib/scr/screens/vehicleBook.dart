import 'package:flutter/material.dart';
import 'package:Daplieh/scr/screens/payment.dart';

class BookDetailsVehicle extends StatelessWidget {
  final String vtype,model,vehicleno,cost,time,date,vimage;
  BookDetailsVehicle({Key key,
  @required this.vtype,
  @required this.model,
  @required this.vehicleno,
  @required this.cost,
  @required this.time,
  @required this.date,
  @required this.vimage
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        elevation: 0.1,
        iconTheme: new IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: new ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(text: 'Booking ', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Colors.pinkAccent)),
                  TextSpan(text: 'Details')
                ], style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: Colors.black)),
              ),
            ),
          ),
          SizedBox(height: 30,),
          new Container(
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
              padding: EdgeInsets.all(15),
              child: new Column(
                children: <Widget>[
                  SizedBox(height: 10,),
                  new Row(
                    children: <Widget>[
                      new Padding(padding: const EdgeInsets.fromLTRB(10, 10, 20, 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              'Model Name: ',
                              textAlign:TextAlign.left,
                              style: new TextStyle(
                                  fontSize: 20.0,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      new Padding(padding: const EdgeInsets.fromLTRB(10, 10, 20, 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              model,
                              textAlign:TextAlign.left,
                              style: new TextStyle(
                                  fontSize: 20.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Padding(padding: const EdgeInsets.fromLTRB(10, 10, 20, 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              'Vehicle Type: ',
                              textAlign:TextAlign.left,
                              style: new TextStyle(
                                  fontSize: 20.0,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      new Padding(padding: const EdgeInsets.fromLTRB(10, 10, 20, 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              vtype,
                              textAlign:TextAlign.left,
                              style: new TextStyle(
                                  fontSize: 20.0),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                  new Row(
                    children: <Widget>[
                      new Padding(padding: const EdgeInsets.fromLTRB(10, 10, 20, 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              'Vehicle No: ',
                              textAlign:TextAlign.left,
                              style: new TextStyle(
                                  fontSize: 20.0,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      new Padding(padding: const EdgeInsets.fromLTRB(10, 10, 20, 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              vehicleno,
                              textAlign:TextAlign.left,
                              style: new TextStyle(
                                  fontSize: 20.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  new Row(
                    children: <Widget>[
                      new Padding(padding: const EdgeInsets.fromLTRB(10, 10, 20, 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              'Date: ',
                              textAlign:TextAlign.left,
                              style: new TextStyle(
                                  fontSize: 20.0,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      new Padding(padding: const EdgeInsets.fromLTRB(10, 10, 20, 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              "$date At $time",
                              textAlign:TextAlign.left,
                              style: new TextStyle(
                                  fontSize: 20.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),


                  new Row(
                    children: <Widget>[
                      new Padding(padding: const EdgeInsets.fromLTRB(10, 10, 20, 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              'Total Amount: ',
                              textAlign:TextAlign.left,
                              style: new TextStyle(
                                  fontSize: 20.0,fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      new Padding(padding: const EdgeInsets.fromLTRB(10, 10, 20, 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              "Rs. $cost",
                              textAlign:TextAlign.left,
                              style: new TextStyle(
                                  fontSize: 20.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
          ),
          SizedBox(height: 40,),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RaisedButton(

                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => Payment(
                      modelName: model,
                      vehType: vtype,
                      vehNo: vehicleno,
                      date: date,
                      time: time,
                      amount: cost,
                      vimage: vimage
                  )),);
                },
                color: Colors.green,
                padding: EdgeInsets.all(15),
                child: Text('Go to Payment',style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

