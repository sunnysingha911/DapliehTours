import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:Daplieh/scr/screens/home.dart';
import 'package:Daplieh/scr/screens/register.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'loginState.dart' as globals;
import 'package:Daplieh/scr/models/source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OTPPhoneNo extends StatefulWidget {
  @override
  _OTPPhoneNoState createState() => _OTPPhoneNoState();
}

class _OTPPhoneNoState extends State<OTPPhoneNo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        elevation: 0.1,
        iconTheme: new IconThemeData(color: Colors.black),
        backgroundColor: Colors.white.withOpacity(0.9),
      ),
      body: OTPVerify(),
    );
  }
}

class OTPVerify extends StatefulWidget {
  @override
  _OTPVerifyState createState() => _OTPVerifyState();
}

class _OTPVerifyState extends State<OTPVerify> {
  String smsCode,verificationID;
  Country _selected;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: new ListView(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(text: 'Phone ', style: TextStyle(fontSize: 50, fontWeight: FontWeight.w700, color: Colors.pinkAccent)),
                    TextSpan(text: 'V', style: TextStyle(fontSize: 50, fontWeight: FontWeight.w700)),
                    TextSpan(text: 'erification')
                  ], style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: Colors.black)),
                ),
              ),
            ),
            new Container(
              margin: new EdgeInsets.all(15),
              child: otpUI(),
            )
          ],
        ),
      )
    );
  }

  Widget otpUI(){
    return new Column(
      children: <Widget>[
        new Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Text(
              'Phone No',
              textAlign:TextAlign.left,
              style: new TextStyle(
                  fontSize: 20.0,fontWeight: FontWeight.bold),
            ),
          ),
        ),
        new Row(
          children: <Widget>[
            new CountryPicker(
              dense: false,
              showFlag: true,  //displays flag, true by default
              showDialingCode: true, //displays dialing code, false by default
              showName: false,
              onChanged: (Country country){
                setState(() {
                  _selected = country;
                });
              },
              selectedCountry: _selected,
            ),
          new Flexible(child: new TextField(
            decoration: new InputDecoration(labelText: 'Phone No',hintText: 'Enter Your Phone No',),
            keyboardType: TextInputType.number,
            maxLength: 10,
            onChanged: (value){
              userPhoneNo = '+'+_selected.dialingCode+value;
            },
          ),)
          ],

        ),

        new SizedBox(height: 400,),
        new RaisedButton(
          onPressed: () {
            checkTextField();
          },
          child: new Text('Send OTP'),
        ),
      ],
    );
  }

  Future<void> checkTextField() async{
    if(userPhoneNo==null){
      Fluttertoast.showToast(
          msg: "Phone No Field Empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }else{
      _sendCodeToPhoneNumber();
      _otpPopup(context);
    }
  }

  Future<void> _otpPopup(BuildContext context){
    return showDialog(context: context, builder:(BuildContext context){
      return AlertDialog(
        title: Text('Enter Your OTP'),
        content: SingleChildScrollView(
            child: new Column(
              children: <Widget>[
                new Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: Text(
                      'OTP',
                      textAlign:TextAlign.left,
                      style: new TextStyle(
                          fontSize: 20.0,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                new TextField(
                  decoration: new InputDecoration(labelText: 'OTP',hintText: 'OTP'),
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  onChanged: (value){
                    this.smsCode = value;
                  },
                ),
                  new RaisedButton(
                        child: new Text('Verify'),
                        onPressed: (){
                          FirebaseAuth.instance.currentUser().then((user){
                            signIn();
                            Navigator.of(context).pop();
                          });
                        },
                  ),
              ],
            )
        ),
      );
    });
  }

  Future<void> _sendCodeToPhoneNumber() async {
    final PhoneVerificationCompleted verificationCompleted = (user) async {
      print("Success");
    };

    final PhoneVerificationFailed verificationFailed = (AuthException authException) {
      setState(() {
        print('Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');}
      );
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.verificationID = verificationId;
      print("code sent to " + userPhoneNo);
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.verificationID = verificationId;
      print("time out");
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: userPhoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  signIn()async{
    AuthCredential credential= PhoneAuthProvider.getCredential(
        verificationId: verificationID,
        smsCode: smsCode
    );
    await firebaseAuth.signInWithCredential(credential).then((user){

      //Navigator.push(context,MaterialPageRoute(builder: (context) => Home()),);
      print('signed in with phone number successful: user -> $user');
      globals.isLoggedIn=true;
      fetchDetails();
    }).catchError((e){
      print("Not Verified");
      Fluttertoast.showToast(
          msg: "Phone Verification Failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.of(context).pop();
    });
  }

  fetchDetails(){
    FirebaseDatabase.instance.reference().child('Registration').orderByChild('PhoneNo').equalTo(userPhoneNo).once().then((DataSnapshot snapshot){
      if(snapshot.value==null){
        Navigator.push(context,MaterialPageRoute(builder: (context) => Register()),);
      }else {
        var result = snapshot.value.values as Iterable;
        for (var item in result) {
          userId = item['id'];
          userDob = item['DoB'];
          userDrvLicB = item['Driving_lic_back'];
          userDrvLicF = item['Driving_lic_fornt'];
          userEmail = item['Email'];
          userName = item['Name'];
          userProfilePic = item['Profile_pic'];
          userGender = item['Gender'];
          userPhoneNo = item['PhoneNo'];
        }
        List<String> myData = [
        userId,
        userName,
        userEmail,
        userGender,
        userDob,
        userProfilePic,
        userDrvLicF,
        userDrvLicB,
        userPhoneNo
        ];
        saveData(myData);
        Navigator.push(context,MaterialPageRoute(builder: (context) => Home()),);
      }
    });
  }

  saveData(List<String> value) async{
    final pref = await SharedPreferences.getInstance();
    pref.setStringList("MyDataList", value);
    pref.setBool("FirstLaunch", false);
  }
}




