import 'package:acm1/login/SIGNUP.dart';
import 'package:acm1/views/menulist.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

//import 'package:tshirts/pages/forgotpassword.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username = "";
  String password = "";
  bool userEmpty = false;
  bool passEmpty = false;
  bool showPass = false;

  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
    'App_id': 'f1a053fe-e6a1-4318-80bd-f029c9222a69',
  };
  String url = 'https://auth.grow90.org/phone/signin';
  String payload;

  checkforkey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('stringValue');
    print(stringValue);
    if (stringValue != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MenuList()));
    }
  }

  @override
  void initState() {
    // ignore: todo
    //TODO: implement initState
    super.initState();
    checkforkey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(
              flex: 2,
            ),
            Text(
              "Login",
              style: TextStyle(
                  color: Colors.blue[800],
                  fontSize: 45,
                  fontWeight: FontWeight.bold),
            ),
            Spacer(
              flex: 2,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: <Widget>[
                    TextField(
                      onChanged: (text) {
                        username = text;
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
                            borderSide: userEmpty
                                ? BorderSide(color: Colors.red)
                                : BorderSide(color: Colors.grey[900]),
                          ),
                          labelText: "Mobile",
                          prefix: Text("+91  "),
                          prefixIcon: Icon(
                            Icons.phone,
                            color: userEmpty ? Colors.red : Colors.grey,
                          )),
                      onTap: () {
                        if (userEmpty) {
                          setState(() {
                            userEmpty = false;
                          });
                        }
                      },
                      autofocus: true,
                    ),
                    userEmpty
                        ? Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 15,
                            child: Text(
                              "               mobile field cannot be empty",
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
                          height: 12,
                        ),
                ],
              ),
            ),
            Spacer(),
            Container(
              width: 200,
              height: 50,
              child: FlatButton(
                color: Colors.blue[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  if (username.isEmpty) {
                    setState(() {
                      userEmpty = true;
                    });
                  }
                  if (password.isEmpty) {
                    setState(() {
                      passEmpty = true;
                    });
                  }
                  if (passEmpty || userEmpty) {
                    return;
                  }
//                  payload = '{\n    \"phone\": \"$username\",\n    \"otp\": \"$password\"\n}';
                  payload = '{"phone": "$username","password": "$password"}';
                  var response = await signinapi();
                  if (response["type"] == "success") {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('stringValue', response["auth_token"]);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => MenuList()));
                  } else if (response["type"] == "failure") {
                    Fluttertoast.showToast(
                        msg: "phonenumber or password is incorrect",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 2,
                        backgroundColor: Colors.grey[800],
                        textColor: Colors.white,
                        fontSize: 14.0);
                  }
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 200,
              height: 50,
              child: FlatButton(
                color: Colors.blue[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Signup()));
                },
                child: Text(
                  "New? Signup",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            /*       InkWell(
              child: Text("Forgot Password?"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ForgotPassword()));
              },
            ),*/
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  signinapi() async {
    var response = await http.post(url, body: payload, headers: requestHeaders);
    print('Response status: ${response.statusCode}');
    Map parsed = json.decode(response.body);
    return parsed;
  }
}
