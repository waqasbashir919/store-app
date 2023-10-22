import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/constants/contants.dart';
import 'package:store/main.dart';
import 'package:store/services/remote_services.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

final GlobalKey<FormState> formKey = GlobalKey<FormState>();
String p =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

RegExp regExp = new RegExp(p);
String? username;
String? password;
String error = '';
bool isHideText = true;
bool isLogin = false;

class _LoginPageState extends State<LoginPage> {
  void validatation() async {
    final FormState form = formKey.currentState!;
    if (formKey.currentState!.validate()) {
      setState(() {
        isLogin = true;
      });
      dynamic result = await signInWithEmailandPassword(username!, password!);

      if (result == null) {
        setState(() {
          error = "User does not exist";
        });
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      }
      setState(() {
        isLogin = false;
      });
    } else {
      print("Something is incorrect");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          reverse: true,
          child: Form(
            key: formKey,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('${Constant.loginImg}'),
                      fit: BoxFit.cover)),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: 150,
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 320,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          onChanged: (val) {
                            setState(() {
                              username = val;
                            });
                          },
                          validator: (value) {
                            if (value == "") {
                              return "Please fill the username box";
                            }
                            //  else if (!regExp.hasMatch(value!)) {
                            //   return "Invalid username format";
                            // }
                            else {
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              hintText: "Username",
                              border: OutlineInputBorder(),
                              hintStyle: TextStyle(color: Colors.black)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          obscureText: isHideText,
                          validator: (value) {
                            if (value == "") {
                              return "Please type password";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isHideText = !isHideText;
                                  });
                                },
                                child: Icon(
                                  isHideText == true
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: isLogin
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Text("Login"),
                            onPressed: () async {
                              validatation();
                            },
                          ),
                        ),
                        Center(
                          child: Text(
                            error,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> signInWithEmailandPassword(
      String username, String password) async {
    final token = await RemoteServices.signIn(username, password);
    if (token != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
      return token;
    }
  }
}
