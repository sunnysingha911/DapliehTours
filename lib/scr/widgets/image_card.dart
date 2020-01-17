import 'dart:convert';
import 'package:Daplieh/scr/models/source.dart';
import 'package:flutter/material.dart';
import 'package:Daplieh/scr/models/places.dart';
import 'package:Daplieh/scr/screens/details.dart';

class ImageCard extends StatelessWidget {
  String tripname,duration,source,destination,info,cost;
  var picture;
  final PlaceDetailListItem place;
  ImageCard({
    @required this.tripname,
    @required this.picture,
    @required this.duration,
    @required this.destination,
    @required this.source,
    @required this.info,
    @required this.cost,
    this.place});

  @override
  Widget build(BuildContext context) {
    dispPic=picture;
    return Padding(
      padding: EdgeInsets.all(4),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=> Details(place)));
        },
        child: Container(
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: <Widget>[
                Image.memory(base64Decode(picture),height: double.infinity,width: 200,fit: BoxFit.cover,),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        // Box decoration takes a gradient
                        gradient: LinearGradient(
                          // Where the linear gradient begins and ends
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          // Add one stop for each color. Stops should increase from 0 to 1
                          colors: [
                            // Colors are easy thanks to Flutter's Colors class.
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.7),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.4),
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0.05),
                            Colors.black.withOpacity(0.025),
                          ],
                        ),
                      ),

                      child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container()
                      )
                  ),
                ),

                Positioned(
                  bottom: 30,
                  left: 5,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: RichText(text: TextSpan(children: [
                            TextSpan(text: '$tripname ', style: TextStyle(fontSize: 22)),
                          ])
                        )
                    ),
                  ),
                ),

                Positioned(
                  bottom: 10,
                  left: 5,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.calendar_today, color: Colors.white, size: 14,),
                            SizedBox(width: 5,),
                            Text('$duration', style: TextStyle(color: Colors.white)),
                            Text('             Rs. $cost', style: TextStyle(color: Colors.white))
                          ],
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
