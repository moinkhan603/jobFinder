import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:job_application/Welcome.dart';
import 'package:job_application/signUp.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'CRUD.dart';
import 'companyWelcome.dart';
class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool showSpinner = false;
  String email;
  String password;
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
  //  loggedinuser();
    super.initState();
  }

  loggedinuser() async {
    await FirebaseAuth.instance.currentUser().then((firebaseUser) {
      if (firebaseUser == null) {
        //signed out
      } else if (firebaseUser != null){
        //signed in
         CRUD.myuserid= firebaseUser.uid;
        print(firebaseUser.uid);
        CRUD.AddData();
        if(CRUD.type=="Employee"){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Welcome()),
          );
        }
        else{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CWelcome()),
          );
        }

      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Colors.grey.shade300,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(16.0),

                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 40.0, bottom: 20.0),
                      height: 80,
                    ),
                    Text(
                      "JOB PORTAL",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 40.0),
                    TextField(
                      onChanged: (String value) {
                        email = value.trim();
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(16.0),
                        prefixIcon: Container(
                            padding:
                            const EdgeInsets.only(top: 16.0, bottom: 16.0),
                            margin: const EdgeInsets.only(right: 8.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    bottomLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0),
                                    bottomRight: Radius.circular(10.0))),
                            child: Icon(
                              Icons.person,
                              color: Colors.black,
                            )),
                        hintText: "enter your email",
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.3),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    TextField(
                      onChanged: (String value) {
                        password = value.trim();
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(16.0),
                        prefixIcon: Container(
                            padding:
                            const EdgeInsets.only(top: 16.0, bottom: 16.0),
                            margin: const EdgeInsets.only(right: 8.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    bottomLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0),
                                    bottomRight: Radius.circular(10.0))),
                            child: Icon(
                              Icons.lock,
                              color: Colors.black,
                            )),
                        hintText: "enter your password",
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.3),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 30.0),
                    SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        color: Colors.black,
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(20.0),
                        child: Text("Login".toUpperCase()),
                        onPressed: () async{


                          if (email == null || password == null) {
                            Fluttertoast.showToast(
                              msg: "Fields cannot be empty",
                              toastLength: Toast.LENGTH_LONG,
                            );
                            return;
                          }
                          if (email.contains("@") == false) {
                            print(email.contains("@"));
                            Fluttertoast.showToast(
                              msg: "Email not valid",
                              toastLength: Toast.LENGTH_LONG,
                            );
                            return;
                          }

                          if (email != null && password != null) {
                            setState(() {
                              showSpinner = true;
                            });

                            try {
                              FirebaseUser newuser = (await _auth
                                      .signInWithEmailAndPassword(
                                  email: email,
                                  password: password))
                              .user;

                          if (newuser != null &&
                          newuser.isEmailVerified == true) {
                          CRUD.email = email;
CRUD.myuserid=newuser.uid;
                          if(CRUD.type=="Employee")
                          {
                            print(CRUD.myuserid);
                            CRUD.AddData();
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) =>
                          Welcome()),
                          );
                          }
                          else{
                            CRUD.AddData();
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) =>
                          CWelcome()),
                          );


                          }





                          } else {
                          Fluttertoast.showToast(
                          msg:
                          "Please Verify Your Email.",
                          gravity: ToastGravity.CENTER);
                          }
                          setState(() {
                          showSpinner = false;
                          });
                          } catch (e) {
                          print(e);
                          Fluttertoast.showToast(
                          msg:
                          "Incorrect email or password",
                          gravity: ToastGravity.CENTER);

                          setState(() {
                          showSpinner = false;
                          });
                          }
                          }






                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          textColor: Colors.black,
                          child: Text("Create Account".toUpperCase()),
                          onPressed: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUp()),
                            );
                          },
                        ),
                        Container(
                          color: Colors.black,
                          width: 2.0,
                          height: 20.0,
                        ),
                        FlatButton(
                          textColor: Colors.black,
                          child: Text("Forgot Password".toUpperCase()),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    //SizedBox(height: 10.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
