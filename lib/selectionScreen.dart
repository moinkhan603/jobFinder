import 'package:flutter/material.dart';
import 'CRUD.dart';
import 'companyWelcome.dart';
import 'package:job_application/signIn.dart';

class SelectCategory extends StatefulWidget {
  @override
  _SelectCategoryState createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body:
      Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          RaisedButton(
            onPressed: (){
              CRUD.type="Employee";
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignIn()),
              );
            },
            textColor: Colors.white,
            color: Colors.red,
            padding: const EdgeInsets.all(8.0),
            child: new Text(
              "Register As Employee"
              ,
            ),
          ),
          RaisedButton(
            onPressed: (){
              CRUD.type="Company";
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignIn()),
              );
            },
            textColor: Colors.white,
            color: Colors.black,
            padding: const EdgeInsets.all(8.0),
            child: new Text(
              "Register As Company",
            ),
          )


        ],),
      ),
    );
  }
}
