import 'dart:async';
import 'package:acm1/views/gridsview.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Otp extends StatefulWidget {
  @override
  _OtpState createState() => _OtpState();

  final String urlreg = 'https://auth.grow90.org/phone/register';
  final String urlverify = "https://auth.grow90.org/phone/verify_otp";
  final String mobile;
  final String payload;

  final Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
  };

  Otp({Key key, @required this.mobile, @required this.payload})
      : super(key: key);
}

class _OtpState extends State<Otp> {
  TextEditingController textEditingController = TextEditingController();

  // ignore: close_sinks
  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Spacer(),
            Text(
              "VERIFY YOUR MOBILE",
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800]),
            ),
            Spacer(),
            Text(
              "We have sent an OTP on your number",
              style: TextStyle(fontSize: 15, color: Colors.grey[500]),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "+91-" + widget.mobile,
              style: TextStyle(fontSize: 15, color: Colors.grey[500]),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Not you number? ",
                  style: TextStyle(fontSize: 15, color: Colors.grey[500]),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "edit",
                    style: TextStyle(fontSize: 15, color: Colors.blue),
                  ),
                ),
              ],
            ),
            Spacer(),
            Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                child: Form(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 30),
                      child: PinCodeTextField(
                        length: 6,
                        obsecureText: false,
                        animationType: AnimationType.slide,
                        validator: (v) {
                          if (v.length < 3) {
                            return "I'm from validator";
                          } else {
                            return null;
                          }
                        },
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(10),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor:
                              hasError ? Colors.orange : Colors.white,
                        ),
                        animationDuration: Duration(milliseconds: 300),
                        backgroundColor: Colors.blue.shade50,
                        enableActiveFill: false,
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        onCompleted: (v) async {
                          print(currentText);
                          print(widget.mobile);
//                          var response = await verify_otp('{"phone": "${widget.mobile}","password": "${currentText}"}');
                          var response = await verifyotp(
                              '{\n    \"phone\": \"${widget.mobile}\",\n    \"otp\": \"$currentText\"\n}');
                          print(response);
                          if (response["type"] == "success") {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString(
                                'stringValue', response["auth_token"]);
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GridsView()),
                                (route) => false);
                          } else if (response["type"] == "failure") {
                            Fluttertoast.showToast(
                                msg: "OTP is incorrect",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.grey[800],
                                textColor: Colors.white,
                                fontSize: 14.0);
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          print("Allowing to paste $text");
                          //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                          //but you can show anything you want here, like your pop up saying wrong paste format or etc
                          return true;
                        },
                      )),
                )),
            Spacer(),
            InkWell(
              onTap: () async {
                // ignore: unused_local_variable
                var token = await registerapi();
              },
              child: Text(
                "Resend OTP?",
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }

  registerapi() async {
    var response = await http.post(widget.urlreg,
        body: widget.payload, headers: widget.requestHeaders);
    print(response);
    Map parsed = json.decode(response.body);
    print(parsed);
    return parsed;
  }

  verifyotp(String payload) async {
    var response = await http.post(widget.urlverify,
        body: payload, headers: widget.requestHeaders);
    Map parsed = json.decode(response.body);
    return parsed;
  }
}
