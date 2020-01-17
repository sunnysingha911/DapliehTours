import 'package:flutter/material.dart';
import 'package:Daplieh/scr/widgets/images_cars.dart';

class NavCars extends StatefulWidget {
  @override
  _NavCarsState createState() => _NavCarsState();
}

class _NavCarsState extends State<NavCars> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
        elevation: 0.1,
        iconTheme: new IconThemeData(color: Colors.black),
    backgroundColor: Colors.white,
    ),
    body: Cars()
    );
  }
}

class Cars extends StatefulWidget {
  @override
  _CarsState createState() => _CarsState();
}

class _CarsState extends State<Cars> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(text: 'Cars, ', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700, color: Colors.pinkAccent)),
                  TextSpan(text: 'for Self Drive')
                ], style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: Colors.black)),
              ),
            ),
          ),

          Container(
            height: 450,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    //IconButton(icon: Icon(Icons.more_horiz, color: Colors.black,), onPressed: (){},),
                    SizedBox(height: 50),
                  ],
                ),

                Expanded(child: Container(child: CarImg())),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


