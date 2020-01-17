import 'package:Daplieh/scr/models/source.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Daplieh/scr/screens/home.dart';
import 'dart:io';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        elevation: 0.1,
        iconTheme: new IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Form_Reg(),
    );
  }
}

class Form_Reg extends StatefulWidget {
  @override
  _Form_RegState createState() => _Form_RegState();
}

class _Form_RegState extends State<Form_Reg> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GlobalKey<FormState> _key= new GlobalKey();
  bool _validate = false;
  int  _radioValue1=0;
  File _image=null,_drvLicF=null,_drvLicB=null;
  DateTime Dob=null;
  final DatabaseReference ref = FirebaseDatabase.instance.reference().child('Registration').push();
setSelectedRadio(int val){
  setState(() {
    _radioValue1=val;
  });
}
  var format = DateFormat("dd-MM-yyyy");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(text: 'User ', style: TextStyle(fontSize: 50, fontWeight: FontWeight.w700, color: Colors.pinkAccent)),
                  TextSpan(text: 'Regstration')
                ], style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: Colors.black)),
              ),
            ),
          ),

          new Container(
            margin: new EdgeInsets.all(15),
              child: new Form(
                key: _key,
                autovalidate: _validate,
                child: FormUI(),
              ),
          )
        ],
      ),
    );
  }
  Widget FormUI(){
    return new Column(
      children: <Widget>[
        new Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Text(
              'Enter Your Name',
              textAlign:TextAlign.left,
              style: new TextStyle(
                fontSize: 20.0,fontWeight: FontWeight.bold),
            ),
          ),
        ),
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Full Name'),
          maxLength: 32,
          validator: validateName,
          onSaved: (String val){
            userName=val;
          },
        ),
        new Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Text(
              'Enter Your Email Id',
              textAlign:TextAlign.left,
              style: new TextStyle(
                fontSize: 20.0,fontWeight: FontWeight.bold),
            ),
          ),
        ),
        new TextFormField(
          decoration: new InputDecoration(hintText: 'Email Id'),
          keyboardType: TextInputType.emailAddress,
          maxLength: 32,
          validator: validateEmail,
          onSaved: (String val){
            userEmail=val;
          },
        ),
        new Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Text(
              'Choose Your Gender',
              textAlign:TextAlign.left,
              style: new TextStyle(
                fontSize: 20.0,fontWeight: FontWeight.bold),
            ),
          ),
        ),

        new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Radio(
              value: 0,
              activeColor: Colors.green,
              groupValue: _radioValue1,
              onChanged: (val){
                setSelectedRadio(val);
              },
            ),
            new Text(
              'Male',
              style: new TextStyle(fontSize: 16.0),
            ),
            new Radio(
              value: 1,
              activeColor: Colors.green,
              groupValue: _radioValue1,
              onChanged: (val){
                setSelectedRadio(val);
              },
            ),
            new Text(
              'Female',
              style: new TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        new Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Text(
              'Date of Birth',
              textAlign:TextAlign.left,
              style: new TextStyle(
                  fontSize: 20.0,fontWeight: FontWeight.bold),
            ),
          ),
        ),
        new SizedBox(
          width: 300,
          child: new RaisedButton(
            onPressed: (){
              showDatePicker(
                  context: context,
                  initialDate: Dob==null ? DateTime.now():Dob,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100)
              ).then((date){
                setState(() {
                  Dob=date;
                });
              });
            },
            child: Dob==null ? new Text('Choose a date'):new Text('${format.format(Dob)}') ,
          ),

        ),
        new SizedBox(height: 15,),
        new Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Text(
              'Choose Your Profile Pic',
              textAlign:TextAlign.left,
              style: new TextStyle(
                fontSize: 20.0,fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(padding: EdgeInsets.all(10),height: 100,width: 150,child: _image==null?Text('No image Selected'):Image.file(_image),),
        new RaisedButton(
            onPressed: (){
              _profileChoose(context);
            }, 
            child: Text('Add Image')
        ),
        new Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Text(
              'Add Driving Licence',
              textAlign:TextAlign.left,
              style: new TextStyle(
                fontSize: 20.0,fontWeight: FontWeight.bold),
            ),
          ),
        ),

        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(padding: EdgeInsets.all(10),height: 150,width: 150,child: _drvLicF==null?Text('No image Selected'):Image.file(_drvLicF),),
            new Container(padding: EdgeInsets.all(10),height: 150,width: 150,child: _drvLicB==null?Text('No image Selected'):Image.file(_drvLicB),),
          ],
        ),

        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new RaisedButton(
                onPressed: (){
                  _drvLicFChoose(context);
                },
                child: Text('Add Front Side')
            ),
            new Container(width: 40),
            new RaisedButton(
                onPressed: (){
                  _drvLicBChoose(context);
                },
                child: Text('Add Back Side')
            ),
          ],
        ),

        new SizedBox(height: 15,),
        new RaisedButton(
            onPressed: _sendToServer,
          child: new Text('Register'),
        ),
      ],
    );
  }
  String validateName(String value){
    String pattern = r'(^[a-zA-z ]*$)';
    RegExp regExp=new RegExp(pattern);
      if(value.length==0){
        return "Name is Required";
      }else if(!regExp.hasMatch(value)){
        return "Name must be Alphabets Only";
      }else
      return null;
  }
  String validateEmail(String value){
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp=new RegExp(pattern);
    if(value.length==0){
      return "Email is Required";
    }else if(!regExp.hasMatch(value)){
      return "Email is not Valid";
    }else
    return null;
  }

  Future<void> _profileChoose(BuildContext context){
    return showDialog(context: context, builder:(BuildContext context){
      return AlertDialog(
        title: Text('Make a Choice:'),
        content: SingleChildScrollView(
            child: new Column(
              children: <Widget>[
                new GestureDetector(
                  child: new ListTile(
                    leading: Text('Camera'),
                    title: const Icon(Icons.camera_alt,color: Colors.black,),
                  ),
                  onTap: (){
                    openCameraProfile();
                    Navigator.of(context).pop();
                  },
                ),
                new GestureDetector(
                  child: new ListTile(
                    leading: Text('Gallery'),
                    title: const Icon(Icons.image,color: Colors.black,),
                  ),
                  onTap: (){
                    openGalleryProfile();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
        ),
      );

    });
  }

  Future<void> _drvLicFChoose(BuildContext context){
    return showDialog(context: context, builder:(BuildContext context){
      return AlertDialog(
        title: Text('Make a Choice:'),
        content: SingleChildScrollView(
            child: new Column(
              children: <Widget>[
                new GestureDetector(
                  child: new ListTile(
                    leading: Text('Camera'),
                    title: const Icon(Icons.camera_alt,color: Colors.black,),
                  ),
                  onTap: (){
                    openCameraDrvLicFront();
                    Navigator.of(context).pop();
                  },
                ),
                new GestureDetector(
                  child: new ListTile(
                    leading: Text('Gallery'),
                    title: const Icon(Icons.image,color: Colors.black,),
                  ),
                  onTap: (){
                    openGalleryDrvLicFront();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
        ),
      );
    });
  }

  Future<void> _drvLicBChoose(BuildContext context){
    return showDialog(context: context, builder:(BuildContext context){
      return AlertDialog(
        title: Text('Make a Choice:'),
        content: SingleChildScrollView(
            child: new Column(
              children: <Widget>[
                new GestureDetector(
                  child: new ListTile(
                    leading: Text('Camera'),
                    title: const Icon(Icons.camera_alt,color: Colors.black,),
                  ),
                  onTap: (){
                    openCameraDrvLicBack();
                    Navigator.of(context).pop();
                  },
                ),
                new GestureDetector(
                  child: new ListTile(
                    leading: Text('Gallery'),
                    title: const Icon(Icons.image,color: Colors.black,),
                  ),
                  onTap: (){
                    openGalleryDrvLicBack();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            )
        ),
      );

    });
  }

  void openCameraProfile()async{
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );
    var result = await FlutterImageCompress.compressAndGetFile(
      croppedFile.path, croppedFile.path,
      quality: 75,
    );
    setState(() {
      _image = croppedFile;
    });
  }
  void openCameraDrvLicFront()async{
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );
    var result = await FlutterImageCompress.compressAndGetFile(
      croppedFile.path, croppedFile.path,
      quality: 75,
    );
    setState(() {
      _drvLicF = croppedFile;
    });
  }
  void openCameraDrvLicBack()async{
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );
    var result = await FlutterImageCompress.compressAndGetFile(
      croppedFile.path, croppedFile.path,
      quality: 75,
    );
    setState(() {
      _drvLicB = croppedFile;
    });
  }
  void openGalleryProfile()async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );
    var result = await FlutterImageCompress.compressAndGetFile(
      croppedFile.path, croppedFile.path,
      quality: 75,
    );
    setState(() {
      _image = croppedFile;
    });
  }
  void openGalleryDrvLicFront()async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );
    var result = await FlutterImageCompress.compressAndGetFile(
      croppedFile.path, croppedFile.path,
      quality: 75,
    );
    setState(() {
      _drvLicF = croppedFile;
    });
  }
  void openGalleryDrvLicBack()async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );
    var result = await FlutterImageCompress.compressAndGetFile(
      croppedFile.path, croppedFile.path,
      quality: 75,
    );
    setState(() {
      _drvLicB = croppedFile;
    });
  }

  _sendToServer(){
    if(_key.currentState.validate()){
        String gender=_radioValue1==0?'male':'female';

      List<int> imageBytes1 = _image.readAsBytesSync();
      String base64Image1 = base64Encode(imageBytes1);

      List<int> imageBytes2 = _drvLicF.readAsBytesSync();
      String base64Image2 = base64Encode(imageBytes2);

      List<int> imageBytes3 = _drvLicB.readAsBytesSync();
      String base64Image3 = base64Encode(imageBytes3);
      _key.currentState.save();

      var data = {
        'Name': userName,
        'Email': userEmail,
        'PhoneNo': userPhoneNo,
        'Gender': gender,
        'DoB': format.format(Dob),
        'Profile_pic': base64Image1,
        'Driving_lic_fornt': base64Image2,
        'Driving_lic_back': base64Image3,
        'id': ref.key,
      };

        userId=ref.key;
        userDob = format.format(Dob);
        userDrvLicB = base64Image3;
        userDrvLicF = base64Image2;
        userEmail = userEmail;
        userName = userName;
        userProfilePic = base64Image1;
        userGender = gender;
        userPhoneNo = userPhoneNo;

        ref.set(data);
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
        Fluttertoast.showToast(
            msg: "Registration Success",
            backgroundColor: Colors.green,
            textColor: Colors.white,
        );
        Navigator.push(context,MaterialPageRoute(builder: (context) => Home()),);
    }else{
      setState(() {
        _validate = true;
      });
    }
  }
  saveData(List<String> value) async{
    final pref = await SharedPreferences.getInstance();
    pref.setStringList("MyDataList", value);
    pref.setBool("FirstLaunch", false);
  }
}



