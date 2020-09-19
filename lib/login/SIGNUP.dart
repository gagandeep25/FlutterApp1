import 'package:acm1/login/OTP.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String url = 'https://auth.grow90.org/phone/register';
  String payload;
//  Map<String, String> data = {
//    "phone": "",
//    "password": ""
//  };
  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
    'App_id': 'f1a053fe-e6a1-4318-80bd-f029c9222a69',
  };

  String name = "";
//  String email = "";
  String mobile = "";
  String password = "";
  String confirmPassword = "";

  String mobileErrors = "";

  bool nameEmpty = false;
  bool mobileEmpty = false;
//  bool emailValid = true;
  bool passEmpty = false;
  bool passConEmpty = false;

  bool invalidPhone = false;
  bool errorPhone = false;

  bool showPass = false;
  bool showPassConfirm = false;

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
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(
                  flex: 4,
                ),
                Text(
                  "Let's Get Started!",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[800]),
                ),
                Spacer(),
                Text(
                  "Create an account to get all features",
                  style: TextStyle(color: Colors.grey),
                ),
                Spacer(
                  flex: 4,
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      children: <Widget>[
                        TextField(
                          onChanged: (text) {
                            name = text;
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(40.0),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(40.0),
                                ),
                                borderSide: nameEmpty
                                    ? BorderSide(color: Colors.red)
                                    : BorderSide(color: Colors.grey[900]),
                              ),
                              labelText: "Name",
                              hintText: "Enter name",
                              prefixIcon: Icon(
                                Icons.person,
                                color: nameEmpty ? Colors.red : Colors.grey,
                              )),
                          onTap: () {
                            if (nameEmpty) {
                              setState(() {
                                nameEmpty = false;
                              });
                            }
                          },
                          autofocus: true,
                        ),
                        nameEmpty
                            ? Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: 15,
                                child: Text(
                                  "               name field cannot be empty",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 10,
                                  ),
                                ))
                            : Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: 15,
                              ),
                      ],
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Column(
                      children: <Widget>[
                        TextField(
                          onChanged: (text) {
                            mobile = text;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(40.0),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(40.0),
                                ),
                                borderSide:
                                    mobileEmpty || invalidPhone || errorPhone
                                        ? BorderSide(color: Colors.red)
                                        : BorderSide(color: Colors.grey[900]),
                              ),
                              labelText: "Mobile",
                              prefix: Text("+91  "),
                              prefixIcon: Icon(
                                Icons.phone,
                                color: mobileEmpty || invalidPhone || errorPhone
                                    ? Colors.red
                                    : Colors.grey,
                              )),
                          onTap: () {
                            setState(() {
                              mobileEmpty = false;
                              invalidPhone = false;
                              errorPhone = false;
                            });
                          },
                        ),
                        mobileEmpty || invalidPhone || errorPhone
                            ? Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: 15,
                                child: Text(
                                  mobileErrors,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 10,
                                  ),
                                ))
                            : Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: 15,
                              ),
                      ],
                    )),
/*           Container(
//                    width: MediaQuery.of(context).size.width * 0.8,
//                    child: Column(
//                      children: <Widget>[
//                        TextField(
//                          onChanged: (text) {
//                            email = text;
//                          },
//                          keyboardType: TextInputType.emailAddress,
//                          decoration: InputDecoration(
//                            focusedBorder: OutlineInputBorder(
//                              borderSide: BorderSide(color: Colors.blue),
//                              borderRadius: const BorderRadius.all(
//                                const Radius.circular(40.0),
//                              ),
//                            ),
//                            enabledBorder: OutlineInputBorder(
//                              borderRadius: const BorderRadius.all(
//                                const Radius.circular(40.0),
//                              ),
//                                borderSide: emailValid?BorderSide(color: Colors.grey[800]):BorderSide(color: Colors.red),
//                            ),
//                            labelText: "Email",
//                              hintText: "Enter email",
//                              prefixIcon: Icon(Icons.email, color: emailValid?Colors.grey:Colors.red,)
//                          ),
//                          onTap: () {
//                              setState(() {
//                                emailValid = true;
//                              });
//                          },
//                        ),
//                        emailValid?Container(
//                          width:  MediaQuery.of(context).size.width * 0.8,
//                          height: 15,
//                        ):Container(
//                            width:  MediaQuery.of(context).size.width * 0.8,
//                            height: 15,
//                            child: Text(
//                              "               email is not valid",
//                              textAlign: TextAlign.start,
//                              style: TextStyle(
//                                color: Colors.red,
//                                fontSize: 10,
//                              ),
//                            )),
//                      ],
                    )), */
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(40.0),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: passEmpty
                                  ? BorderSide(color: Colors.red)
                                  : BorderSide(color: Colors.grey[900]),
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(40.0),
                              ),
                            ),
                            labelText: "Password",
                            prefixIcon: Icon(
                              Icons.lock,
                              color: passEmpty ? Colors.red : Colors.grey,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.remove_red_eye),
                              onPressed: () {
                                setState(() {
                                  showPass = !showPass;
                                });
                              },
                              color: showPass ? Colors.blue : Colors.grey,
                            )),
                        onChanged: (text) {
                          password = text;
                        },
                        onTap: () {
                          if (passEmpty) {
                            setState(() {
                              passEmpty = false;
                            });
                          }
                        },
                        obscureText: !showPass,
                      ),
                      passEmpty
                          ? Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 15,
                              child: Text(
                                "               password field cannot be empty",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                ),
                              ))
                          : Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 15,
                            ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(40.0),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: passConEmpty
                                  ? BorderSide(color: Colors.red)
                                  : BorderSide(color: Colors.grey[800]),
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(40.0),
                              ),
                            ),
                            labelText: "Confirm Password",
                            prefixIcon: Icon(
                              Icons.lock,
                              color: passConEmpty ? Colors.red : Colors.grey,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.remove_red_eye),
                              onPressed: () {
                                setState(() {
                                  showPassConfirm = !showPassConfirm;
                                });
                              },
                              color:
                                  showPassConfirm ? Colors.blue : Colors.grey,
                            )),
                        onChanged: (text) {
                          confirmPassword = text;
                        },
                        onTap: () {
                          if (passConEmpty) {
                            setState(() {
                              passConEmpty = false;
                            });
                          }
                        },
                        obscureText: !showPassConfirm,
                      ),
                      passConEmpty
                          ? Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 15,
                              child: Text(
                                "               confirm password field cannot be empty",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                ),
                              ))
                          : Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              height: 15,
                            ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 15,
                ),
                Spacer(
                  flex: 4,
                ),
                Container(
                  width: 200,
                  height: 50,
                  child: FlatButton(
                    color: Colors.blue[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    onPressed: () async {
//                      var response = await http.get("https://auth.grow90.org/test");
//                      print(response);
                      FocusScope.of(context).unfocus();
                      if (name.isEmpty) {
                        setState(() {
                          nameEmpty = true;
                        });
                      }
                      if (mobile.isEmpty) {
                        setState(() {
                          mobileErrors =
                              "               mobile field cannot be empty";
                          mobileEmpty = true;
                        });
                      }
                      if (password.isEmpty) {
                        setState(() {
                          passEmpty = true;
                        });
                      }
                      if (confirmPassword.isEmpty) {
                        setState(() {
                          passConEmpty = true;
                        });
                      }
                      if (password != confirmPassword) {
                        Fluttertoast.showToast(
                            msg: "Confirm password should be same as password",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.grey[800],
                            textColor: Colors.white,
                            fontSize: 14.0);
                      }
//                      if(email.isNotEmpty){
//                        Pattern pattern =
//                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//                        RegExp regex = RegExp(pattern);
//                        emailValid = regex.hasMatch(email);
//                      }
                      if (nameEmpty ||
                          mobileEmpty ||
                          passEmpty ||
                          passEmpty ||
                          password != confirmPassword) {
                        return;
                      }
                      String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                      RegExp regExp = new RegExp(patttern);
                      if (!regExp.hasMatch(mobile) || mobile.length != 10) {
                        setState(() {
                          invalidPhone = true;
                          mobileErrors =
                              "               enter a vaild mobile number";
                        });
                        return;
                      }
                      payload = '{"phone": "$mobile","password": "$password"}';
                      var token = await registerapi();
                      print(token);
                      if (token["type"] == "success") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Otp(
                                      mobile: mobile,
                                      payload: payload,
                                    )));
                      } else {
                        setState(() {
                          errorPhone = true;
                          mobileErrors =
                              "               check your mobile number";
                        });
                      }
                    },
                    child: Text(
                      "CREATE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 4,
                ),
                Container(
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pop();
                              },
                            text: "Login",
                            style: TextStyle(color: Colors.blue[800]))
                      ],
                    ),
                  ),
                ),
                Spacer(
                  flex: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  registerapi() async {
    var response = await http.post(url, body: payload, headers: requestHeaders);
    print('Response status: ${response.statusCode}');
    Map parsed = json.decode(response.body);
    return parsed;
  }
}
