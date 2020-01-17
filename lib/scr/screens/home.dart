import 'dart:convert';
import 'package:Daplieh/scr/models/source.dart';
import 'package:Daplieh/scr/screens/Profile.dart';
import 'package:Daplieh/scr/screens/bookings.dart';
import 'package:flutter/material.dart';
import 'package:Daplieh/scr/screens/cars.dart';
import 'package:Daplieh/scr/widgets/images_bikes.dart';
import 'package:Daplieh/scr/widgets/images_cars.dart';
import 'package:Daplieh/scr/widgets/images_cards.dart';
import 'package:flutter/material.dart';
import 'register.dart';
import 'trips.dart';
import 'bikes.dart';
import 'cars.dart';
import 'about.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
@override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: Text(userId==null?'UserName':'$userName'),
                accountEmail: Text(userId==null?'EmailId':'$userEmail'),
                currentAccountPicture: GestureDetector(
                  child: ClipOval(
                    child: Image.memory(
                      base64Decode(userId==null?tempProfile:userProfilePic),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  )
                ),
                decoration: new BoxDecoration(
                    color: Colors.amber
                ),
              ),
              InkWell(onTap: (){Navigator.pop(context);},
                child: ListTile(
                  title: Text('Home'),
                  leading: Icon(Icons.home,color: Colors.black),
                ),
              ),
              InkWell(onTap: (){
                Navigator.pop(context);
                Navigator.push(context,MaterialPageRoute(builder: (context) => NavBikes()),);
                },
                child: ListTile(
                  title: Text('Bikes'),
                  leading: Icon(Icons.motorcycle,color: Colors.black),
                ),
              ),
              InkWell(onTap: (){
                  Navigator.pop(context);
                  Navigator.push(context,MaterialPageRoute(builder: (context) => NavCars()),);
                },
                child: ListTile(
                  title: Text('Cars'),
                  leading: Icon(Icons.directions_car,color: Colors.black),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(context,MaterialPageRoute(builder: (context) => NavTrips()),);
                },
                child: ListTile(
                  title: Text('Trips'),
                  leading: Icon(Icons.departure_board,color: Colors.black),
                ),
              ),
              Divider(),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(context,MaterialPageRoute(builder: (context) => NavBookings()),);
                },
                child: ListTile(
                  title: Text('My Trips'),
                  leading: Icon(Icons.trip_origin),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(context,MaterialPageRoute(builder: (context) => NavVehBookings()),);
                },
                child: ListTile(
                  title: Text('My Rides'),
                  leading: Icon(Icons.directions_bike),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(context,MaterialPageRoute(builder: (context) => AboutUs()),);
                },
                child: ListTile(
                  title: Text('About'),
                  leading: Icon(Icons.help,color: Colors.blue,),
                ),
              ),
            ],
          ),
        ),
        appBar: new AppBar(
          elevation: 0.1,
          iconTheme: new IconThemeData(color: Colors.black),
          backgroundColor: Colors.white.withOpacity(0.9),
          actions: <Widget>[
            new IconButton(
                icon: ClipOval(
                  child: Image.memory(
                    base64Decode(userId==null?tempProfile:userProfilePic),
                    width: 100,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                ),
                onPressed: () {
                  //Navigator.push(context,MaterialPageRoute(builder: (context) => Register()),);
                  Navigator.push(context,MaterialPageRoute(builder: (context) => MyProfile()),);
                }
            )
          ],
        ),
        body: ListView(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(text: 'Hello, ', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Colors.pinkAccent)),
                    TextSpan(text: 'welcome to\nDaplieh Tours')
                  ], style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: Colors.black)),
                ),
              ),
            ),
            SizedBox(height: 30,),
            //TRIPS
            Container(
              height: 400,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text('Our Trips in Shillong', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                      ),
                      IconButton(icon: Icon(Icons.arrow_forward_ios, color: Colors.black,), onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => NavTrips()),);
                      },),
                    ],
                  ),
                  //Expanded(child: Container(child: TripCards())),
                  Expanded(child: Container(child: ImageCards())),
                ],
              ),
            ),
            SizedBox(height: 30,),
            //BIKES
            Container(
              height: 300,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text('Our Bikes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                      ),

                      IconButton(icon: Icon(Icons.arrow_forward_ios, color: Colors.black,), onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => NavBikes()),);
                      },),

                    ],
                  ),
                  Expanded(child: Container(child: BikeImg())),
                ],
              ),
            ),
            SizedBox(height: 30,),
            //Cars
            Container(
              height: 300,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Text('Our Cars', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                      ),
                      IconButton(icon: Icon(Icons.arrow_forward_ios, color: Colors.black,), onPressed: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => NavCars()),);
                      },),
                    ],
                  ),

                  Expanded(child: Container(child: CarImg())),
                ],
              ),
            )
          ],
        )
    );
  }
}