import 'package:flutter/material.dart';
import 'package:Daplieh/scr/widgets/images_cards.dart';

class NavTrips extends StatefulWidget {
  @override
  _NavTripsState createState() => _NavTripsState();
}

class _NavTripsState extends State<NavTrips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        elevation: 0.1,
        iconTheme: new IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Trip(),
    );
  }
}

class Trip extends StatefulWidget {
  @override
  _TripState createState() => _TripState();
}

class _TripState extends State<Trip> {
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
                  TextSpan(text: 'Trips, ', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700, color: Colors.pinkAccent)),
                  TextSpan(text: 'we provide in \n Shillong')
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

                Expanded(child: Container(child: ImageCards())),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

