
import 'package:flutter/material.dart';
import 'package:Daplieh/scr/widgets/images_bookings.dart';

class NavVehBookings extends StatefulWidget {
  @override
  _NavVehBookingsState createState() => _NavVehBookingsState();
}

class _NavVehBookingsState extends State<NavVehBookings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          elevation: 0.1,
          iconTheme: new IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
        ),
        body: Vbookings()
    );
  }
}

class Vbookings extends StatefulWidget {
  @override
  _VbookingsState createState() => _VbookingsState();
}

class _VbookingsState extends State<Vbookings> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 5),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(text: 'My ', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700, color: Colors.pinkAccent)),
                  TextSpan(text: 'Rides')
                ], style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: Colors.black)),
              ),
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: VBookingCards(),
          )
        ],
      ),
    );
  }
}

class NavBookings extends StatefulWidget {
  @override
  _NavBookingsState createState() => _NavBookingsState();
}

class _NavBookingsState extends State<NavBookings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          elevation: 0.1,
          iconTheme: new IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
        ),
        body: Bookings()
    );
  }
}

class Bookings extends StatefulWidget {
  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 5),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(text: 'My ', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700, color: Colors.pinkAccent)),
                  TextSpan(text: 'Trips')
                ], style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: Colors.black)),
              ),
            ),
          ),
          SizedBox(height: 15),
          Expanded(
            child: BookingCards(),
          )
        ],
      ),
    );
  }
}