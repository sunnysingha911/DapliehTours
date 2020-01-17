import 'package:Daplieh/scr/models/source.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Payment extends StatefulWidget {
  String modelName,vehType,vehNo,date,time,amount,keyId,vimage;
  Payment({
    Key key,
    @required this.modelName,
    @required this.vehType,
    @required this.vehNo,
    @required this.date,
    @required this.time,
    @required this.amount,
    @required this.vimage
});
  @override
  _PaymentState createState() => _PaymentState(
    modelName: modelName,
    vehType: vehType,
    vehNo: vehNo,
    date: date,
    time: time,
    amount: amount,
    vimage: vimage
  );
}

class _PaymentState extends State<Payment> {
  Razorpay _razorpay;
  String modelName,vehType,vehNo,date,time,amount,vimage;
  int  _radioValue1=0;
  var format = DateFormat("dd-MM-yyyy");
  _PaymentState({
    Key key,
    @required this.modelName,
    @required this.vehType,
    @required this.vehNo,
    @required this.date,
    @required this.time,
    @required this.amount,
    @required this.vimage
  });
  //final DatabaseReference ref = FirebaseDatabase.instance.reference().child('Booking').push();

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout()async{
    var option = {
      'key': 'rzp_test_1WBoyiioBEyt28',
      'amount' : int.parse(amount) * 100,
      'name' : 'SunnySingha.co',
      'description' : modelName + " Booked for Self-Ride",
      'prefill': {'contact': userPhoneNo,'email': userEmail},
      'external' : {
        'wallets' : ['paytm']
      }
    };

    try{
      _razorpay.open(option);
    }catch(e){
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response){
    Fluttertoast.showToast(msg: 'Success: '+response.paymentId);
    _sendToServer();
  }

  void _handlePaymentError(PaymentFailureResponse response){
    Fluttertoast.showToast(msg: 'Error: '+response.code.toString() + "."  + response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response){
    Fluttertoast.showToast(msg: 'External Wallet: '+response.walletName);
  }

  setSelectedRadio(int val){
    setState(() {
      _radioValue1=val;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        elevation: 0.1,
        iconTheme: new IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: new ListView(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(text: 'Payment ', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: Colors.pinkAccent)),
                  TextSpan(text: 'Options')
                ], style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: Colors.black)),
              ),
            ),
          ),

          Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: <Widget>[
                            new Text('Pay Later',style: new TextStyle(fontSize: 25.0,fontWeight: FontWeight.w500,),),
                            new Text('(Pay Cash on Pickup)',style: new TextStyle(fontSize: 15.0,),),
                          ],
                        ),
                      ),
                      new Radio(
                        value: 0,
                        activeColor: Colors.green,
                        groupValue: _radioValue1,
                        onChanged: (val){
                          setSelectedRadio(val);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 6,
                        child: Column(
                          children: <Widget>[
                            new Text('Pay Now',style: new TextStyle(fontSize: 25.0,fontWeight: FontWeight.w500,),),
                            new Text('(Card, Netbanking, UPI, etc..)',style: new TextStyle(fontSize: 15.0,),),
                          ],
                        ),
                      ),
                      new Radio(
                        value: 1,
                        activeColor: Colors.green,
                        groupValue: _radioValue1,
                        onChanged: (val){
                          setSelectedRadio(val);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  new RaisedButton(
                    child: new Text('Proceed'),
                      onPressed: (){
                        _radioValue1==0?_sendToServer():openCheckout();
                      }
                  ),
                ],
              ),
          ),
        ],
      ),
    );
  }
  _sendToServer(){
    String modeOPay=_radioValue1==0?'Cash':'Paid';
    DatabaseReference ref = FirebaseDatabase.instance.reference().child('Registration/$userId/Bookings/SelfRide').push();
    var data = {
      'ModelName': modelName,
      'VehcleType': vehType,
      'VehicleNo': vehNo,
      'Date': date,
      'Time': time,
      'PaymentMode': modeOPay,
      'Amount': amount,
      'Image': vimage,
      'id': ref.key,
    };
    ref.set(data);
    Fluttertoast.showToast(
        msg: "Booking Success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
    //Navigator.push(context,MaterialPageRoute(builder: (context) => Home(UniqId: keyId,)),);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
  }
}
