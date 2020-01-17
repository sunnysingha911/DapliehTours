import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:Daplieh/scr/models/source.dart';
import 'dart:convert';
import 'dart:typed_data';
class MyProfile extends StatelessWidget {
  Uint8List profile = base64.decode(userProfilePic);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        iconTheme: new IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            RichText(
              text: TextSpan(children: [
                TextSpan(text: 'My ', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Colors.pinkAccent)),
                TextSpan(text: 'Profile')
              ], style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: Colors.black)),
            ),
            SizedBox(height: 20,),
            Center(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(50),
                        width: 500,
                        height: 350,
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
                        child: new CircleAvatar(
                            radius: 100,
                            child: ClipOval(
                              child: new Image.memory(
                                base64Decode(userId==null?tempProfile:userProfilePic),
                                width: 240,
                                height: 240,
                                fit: BoxFit.cover,
                              ),
                            )
                        )
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 500,
                      padding: EdgeInsets.all(30),
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
                      child: Column(
                        children: <Widget>[
                          Text(userName, style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
                          SizedBox(height: 20,),
                          Text(userEmail, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                          SizedBox(height: 20,),
                          Text(userPhoneNo, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                          SizedBox(height: 20,),
                          Text("Date of Birth: $userDob", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                          SizedBox(height: 20,),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      padding: EdgeInsets.all(25),
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
                      child: Column(
                        children: <Widget>[
                          Text("Your Driving License", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                          SizedBox(height: 20,),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 50,
                                child: Image.memory(base64Decode(userDrvLicF)),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                flex: 50,
                                child: Image.memory(base64Decode(userDrvLicB)),
                              )

                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
                    RaisedButton(
                      padding: EdgeInsets.all(15),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text("Ok"),
                    )
                  ],
                ),
              ),
            )


          ],
        ),
      )
    );
  }
}
