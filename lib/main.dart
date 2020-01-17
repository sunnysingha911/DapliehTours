import 'package:Daplieh/scr/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:Daplieh/scr/screens/welcome.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Daplieh/scr/models/source.dart';
import 'package:Daplieh/scr/screens/OTPPhoneNo.dart';

void main()async{
  await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final pref = await SharedPreferences.getInstance();
  if(pref.getStringList("MyDataList")!=null){
    List<String> listUser = pref.getStringList("MyDataList") ?? List<String>();
    userId = listUser[0];
    userName = listUser[1];
    userEmail = listUser[2];
    userGender = listUser[3];
    userDob = listUser[4];
    userProfilePic = listUser[5];
    userDrvLicF = listUser[6];
    userDrvLicB = listUser[7];
    userPhoneNo = listUser[8];
  }
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,

          primarySwatch: Colors.grey,
          primaryColor: Colors.grey[50],
          primaryColorBrightness: Brightness.light,

          //this is what you wantf
          accentColor: Colors.grey,
          accentColorBrightness: Brightness.light,
        ),
        home: pref.getBool("FirstLaunch")==null?Welcome():(pref.getBool("FirstLaunch")?OTPPhoneNo():Home()),
      )
  );
}
