import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          elevation: 0.1,
          iconTheme: new IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
        ),
        body: About(),
    );
  }
}

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  _openPhone(BuildContext context)async{
    UrlLauncher.launch('tel:+919863495997');
    Navigator.of(context).pop();
  }

  _openMap(BuildContext context)async{
    UrlLauncher.launch('google.navigation:q=25.563464,91.904102');
    Navigator.of(context).pop();
  }

  Future<void> showChoiceDialog(BuildContext context){
    return showDialog(context: context, builder:(BuildContext context){
      return AlertDialog(
        title: Text('Make a Choice:'),
        content: SingleChildScrollView(
            child: new Column(
              children: <Widget>[
                new GestureDetector(
                  child: new ListTile(
                    leading: Text('Make a Call'),
                    title: const Icon(Icons.call,color: Colors.black,),
                  ),
                  onTap: (){
                    _openPhone(context);
                  },
                ),
                new GestureDetector(
                  child: new ListTile(
                    leading: Text('Navigate Us'),
                    title: const Icon(Icons.navigation,color: Colors.black,),
                  ),
                  onTap: (){
                    _openMap(context);
                  },
                ),
              ],
            )
        ),
      );

    });
  }

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
                  TextSpan(text: 'About, ', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700, color: Colors.pinkAccent)),
                  TextSpan(text: 'Daplieh Tours')
                ], style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: Colors.black)),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.fromLTRB(15,5,15,5),
            child: Column(
              children: [
                Container(
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
                    padding: EdgeInsets.all(20),
                    child: Center(
                        child: Text(
                            'Daplieh Four Wheeler And Two Wheeler Rentals is an online cab and Two wheeler booking aggregator that aims to provide reliable, affordable and safe taxi and two wheeler service to its travellers. With operations across Shillong, Daplieh provides both intercity (outstation) taxi and two wheeler booking services as well as intracity (local) cab and two wheeler services.'
                                '\n\nWe also provide tour packages to various part of Meghalaya , Assam , Arunachal , Sikkim for our clients who want to explore the scenic beauty of the beautiful North East India. Our services are catered to all kinds of clients irrespective of their budget and tastes.'
                                '',style:  TextStyle(fontSize: 20.0),),

                    )
                ),
                SizedBox(height: 10,),
                RaisedButton(onPressed: (){
                  showChoiceDialog(context);
                  },child: Text("Contact Us",),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

