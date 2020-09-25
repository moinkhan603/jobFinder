import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:job_application/jobView.dart';

import 'customDrawer.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {




  StreamSubscription<QuerySnapshot>subscription;

  List<DocumentSnapshot>jobs;
//
//  final CollectionReference collectionReference=
//  Firestore.instance.collection("posts").document(CRUD.id)
//      .collection("comments");
  final CollectionReference collectionReference=
  Firestore.instance.collection("jobs");





  @override
  void dispose() {
    // TODO: implement dispose

    subscription?.cancel();
    super.dispose();

  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    subscription=collectionReference
        .snapshots()
        .listen((datasnapshot){


      setState(() {
        jobs=datasnapshot.documents;
      });


    });

  }




  bool isSearch=false;
  GlobalKey<ScaffoldState> key1 = GlobalKey<ScaffoldState>();
TextStyle Companystyle=TextStyle(fontSize: 25,fontWeight: FontWeight.bold);
TextStyle jobTitlestyle=TextStyle(fontSize: 18,
color: Colors.blueAccent,fontWeight: FontWeight.bold);
TextStyle infoStyle=TextStyle(fontSize: 15,fontWeight: FontWeight.bold,
color: Colors.white);
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 60;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.grey.shade300,
          key: key1,
          drawer: CustomDrawer.buildDrawer(context),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: AppBar(
backgroundColor: Colors.black,
              actions: <Widget>[
//               isSearch?
//                Padding(
//                  padding: const EdgeInsets.only(right:8.0),
//                  child: Align(
//                    alignment: Alignment.centerLeft,
//
//                    child: IconButton(
//                      onPressed: (){
//                        setState(() {
//
//                  isSearch=false;
//
//                        });
//
//                      },
//                      icon: new FaIcon(
//
//                        FontAwesomeIcons.timesCircle,),
//                    ),
//                  ),
//                ):
//                Padding(
//                  padding: const EdgeInsets.only(right:8.0),
//                  child: Align(
//                    alignment: Alignment.centerLeft,
//
//                    child: IconButton(
//                      onPressed: (){
//                        setState(() {
//
//                          isSearch=true;
//
//
//                        });
//
//                      },
//                      icon: new FaIcon(
//
//                        FontAwesomeIcons.search,),
//                    ),
//                  ),
//                )
//




              ],



              leading: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: IconButton(
                  onPressed: () {
                    key1.currentState.openDrawer();
                  },
                  icon: Icon(Icons.dehaze),
                ),
              ),

//            appBar: PreferredSize(
//              preferredSize: Size.fromHeight(65.0),
//              child: AppBar(
//                leading: Padding(
//                  padding: const EdgeInsets.only(top: 18.0),
//                  child: IconButton(
//                    onPressed: () {
//                      key1.currentState.openDrawer();
//                    },
//                    icon: ImageIcon(
//                      AssetImage("assets/images/menu.png"),
//                      size: 30,
//                      color: Colors.white,
//                    ),
//                  ),
//                ),
//                title: Padding(
//                  padding: const EdgeInsets.only(top: 18.0),
//                  child: Text(
//                    "Read Nomi",
//                    style: TextStyle(
//                        color: Colors.white,
//                        fontWeight: FontWeight.bold,
//                        fontSize: 22),
//                  ),
//                ),
//                centerTitle: true,
//                backgroundColor: Color(0xff0087E3),
//                actions: <Widget>[
//                  GestureDetector(
//                    onTap: () {
//                      CRUD.logOut();
//                      Navigator.pushNamed(context, '/signin');
//                    },
//                    child: Padding(
//                      padding: const EdgeInsets.only(top: 25.0),
//                      child: Text(AppLocalizations.of(context).translate('logout'),
//                          style: TextStyle(color: Colors.white, fontSize: 18)),
//                    ),
//                  ),
//                  SizedBox(
//                    width: 5,
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.only(right: 4.0, top: 20),
//                    child: ImageIcon(
//                      AssetImage(
//                        "assets/images/right_arrow.png",
//                      ),
//                      size: 12,
//                      color: Colors.red,
//                    ),
//                  )
//                ],
//              ),
//            ),
              bottom: TabBar(

                tabs: <Widget>[
                  Tab(
                    
                    child: Row(
                      children: <Widget>[
                        Icon(FontAwesomeIcons.paperPlane, color: Colors.white),
                        SizedBox(width: 10,),
                        Text('Applied ', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      children: <Widget>[
                        Icon(FontAwesomeIcons.briefcase, color: Colors.white),
                        SizedBox(width: 10,),
                        Text('Jobs', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),

                  Tab(
                    child: Row(
                      children: <Widget>[
                        Icon(FontAwesomeIcons.checkCircle
                            , color: Colors.white),
                        SizedBox(width: 10,),
                        Text('Completed', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),

                ],
              ),

              title: !isSearch? Text("Job Finder",style: TextStyle(
                  fontFamily: 'Spicy Rice'
              ),

              ):Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextField(
                  onChanged:(value){
                   // myfilter(value);

                  } ,
                  style: TextStyle(color: Colors.white,fontSize: 18),

                  decoration: InputDecoration(hintText:"Search Jobs",hintStyle:TextStyle(
                      color: Colors.white
                  ),
                    icon: new Icon(Icons.search,color: Colors.white,),

                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),



                ),
              )

              ,centerTitle: true,

            ),


            ),

          body: TabBarView(
            children: <Widget>[
              Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                    Text("Your Countdown",style: TextStyle(fontSize: 30, color: Colors.black),),
                      SizedBox(height: 10,),
                      Card(
                        elevation: 11,
                        color: Colors.grey,
                        child: CountdownTimer(
                        endTime: endTime,
                        textStyle: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                      ),

                  ],),
                ),
              ),
                            
                            
                            
                            
         jobs!=null?
         ListView.builder(

         itemCount: jobs.length,
    itemBuilder: (BuildContext ctxt, int index) {
    //  String docID = jobs[index].documentID.toString();

//      String title = jobs[index].data['title'];
//      String price = jobs[index].data['price'];
      String companyID=jobs[index].data['c_id'];

                        String jobTitle=jobs[index].data['job_title'];

                        String location=jobs[index].data['location'];

                        String qualification=jobs[index].data['qualification'];

                        String description=jobs[index].data['description'];

                        String type=jobs[index].data['type'];

                        String doc_id=jobs[index].documentID.toString();

                        print(doc_id);
//
   return   StreamBuilder(


          stream:  Firestore.instance.collection("Company")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData)
            {




              for (int index=0;index<snapshot.data.documents.length;index++)
              {
                String CName = snapshot.data.documents[index]['name'];

                        String  Cimg = snapshot.data.documents[index]['img'];

                        print(doc_id);

                        return JobCard(CName,Cimg,jobTitle,type,location,description,qualification,doc_id);


              }

              return Container();







            }

            else {
              return Center(child: CircularProgressIndicator());
            }



//        child:
//        ListView(
//          padding: EdgeInsets.all(10),
//          physics: BouncingScrollPhysics(),
//
//
////
////                        children: <Widget>[
////                          JobCard(),
////                          JobCard(),
////                          JobCard(),
////                          JobCard(),
////                          JobCard(),
////
////                        ],
//
//        );


          }
      );
    }

    ):Center(child: CircularProgressIndicator()),
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
//                            StreamBuilder(
//
//
//
//                  stream:  Firestore.instance.collection("jobs")
//
//                      .snapshots(),
//
//                  builder: (context, snapshot) {
//
//                    if (snapshot.hasData) {
//
//
//
//
//
//
//
//                      for (int index=0;index<snapshot.data.documents.length;index++)
//
//                      {
//
//                        String companyID=snapshot.data.documents[index]['c_id'];
//
//                        String jobTitle=snapshot.data.documents[index]['job_title'];
//
//                        String location=snapshot.data.documents[index]['location'];
//
//                        String qualification=snapshot.data.documents[index]['qualification'];
//
//                        String description=snapshot.data.documents[index]['description'];
//
//                        String type=snapshot.data.documents[index]['type'];
//
//                        String doc_id=snapshot.data.documents[index].documentID.toString();
//
//                        print(doc_id);
//
//
//
//
//
//
//
//                           return StreamBuilder(
//
//                      stream:  Firestore.instance.collection("Company")
//
//                          .snapshots(),
//
//                      builder: (context, snapshot) {
//
//                        if (snapshot.hasData) {
//
//
//
//
//
//
//
//              //        for (int index=0;index<snapshot.data.documents.length;index++) {
//
//
//
//
//
//              return ListView.builder(
//
//
//
//
//                      itemCount: snapshot.data.documents.length,
//
//                      itemBuilder: (BuildContext ctxt, int index) {
//
//
//
//                        String CName = snapshot.data.documents[index]['name'];
//
//                        String  Cimg = snapshot.data.documents[index]['img'];
//
//                        print(doc_id);
//
//                        return JobCard(CName,Cimg,jobTitle,type,location,description,qualification,doc_id);
//
//                      }
//
//
//
//              );
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//              //          String CName = snapshot.data.documents[index]['name'];
//
//              //        String  Cimg = snapshot.data.documents[index]['img'];
//
//              //          return JobCard(CName,Cimg,jobTitle,type,location,description,qualification,doc_id);
//
//              //        }
//
//
//
//
//
//              return Container();
//
//
//
//
//
//
//
//              //            return ListView.builder(
//
//              //
//
//              //            itemCount: snapshot.data.documents.length,
//
//              //        itemBuilder: (BuildContext ctxt, int index) {
//
//              //
//
//              //          String CName = snapshot.data.documents[index]['name'];
//
//              //         String  Cimg = snapshot.data.documents[index]['img'];
//
//              //print(CName);
//
//              //              return JobCard(CName,Cimg,jobTitle,type);
//
//              //
//
//              //
//
//              //        }
//
//              //
//
//              //
//
//              //
//
//              //
//
//              //
//
//              //        );
//
//
//
//
//
//
//
//
//
//                        }
//
//                        else {
//
//                          return Center(child: CircularProgressIndicator());
//
//                        }
//
//
//
//
//
//                      }
//
//
//
//
//
//
//
//
//
//
//
//                      );
//
//
//
//                        //return JobCard(title,price,date,status);
//
//
//
//                      }
//
//
//
//
//
//                    }
//
//                    else {
//
//                      return Center(child: CircularProgressIndicator());
//
//                    }
//
//
//
//                  }
//
//
//
//
//
//              ),

              ListView(
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  Card1(),
                  Card1(),
                  Card1(),

                ],
              ),


            ],
          ),
        ),
      ),
    );
  }

  Widget JobCard(cname,cimg,title,type,loc,des,qual,doc_id) {
    return Container(
      //padding: EdgeInsets.only(top: 100,bottom: 100),
    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 6),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        color: Colors.white.withOpacity(0.88),
        elevation: 5,
        child: Column(
//crossAxisAlignment: CrossAxisAlignment.start,
// crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

        Text(cname,style: Companystyle,
          textAlign: TextAlign.left,),
        SizedBox(height: 8,),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
flex: 2,
                child: Container(
                  child: Text(title,style: jobTitlestyle,


                  ),
                ),
              ),

              Expanded(
flex: 1,
                child: Container(
                  child: CircleAvatar(child:
                  Image.network(cimg),
                  radius: 25,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              )

            ],
          ),
        ),
            SizedBox(height: 5,),
            Row(
mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
          Text("Type ",style: TextStyle(

            color: Colors.black87

          ),


          ),

             Text(" |  "),


                Text(type,textAlign: TextAlign.left,)
        ],),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
Expanded(
  flex: 0,
    child: Icon(FontAwesomeIcons.userTie,color: Colors.black,)),
            Expanded(

              child: Text("Applicants : 6",
              style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold),

              ),
            ),
            Flexible(

              child: FlatButton(
                splashColor: Colors.blueAccent,
                shape:   RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
      ),
                onPressed: ()
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => JobView(
                      cimg,cname,type,loc,title,des,qual,doc_id


                    )),
                  );
                },
                color: Colors.black,
                child:
              Text("view",style: infoStyle,),
              ),
            )
          ],
        )

          ],
        ),
      ),
    );
  }
}


class Card1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 150,
                  child: Container(
                    
                    padding: EdgeInsets.all(20),
                    child:

                    Column(
                      children: <Widget>[



                        Row(
                          
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius:30,
                            child: Image.network("https://icons-for-free.com/iconfiles/png/512/Google-1320568266385361674.png"),

                          ),

                          Text("Company Review",style: TextStyle(fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 25
                          ),)

                        ],),

                    RatingBar(
                      itemSize: 30,
                      initialRating: 3.5,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    )

                      ],
                    ),
                    decoration: new BoxDecoration(


                      gradient: new LinearGradient(
                          colors: [Colors.black, Colors.black],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),

                    ),

                  ),

                ),
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    header: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Your Review",
                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                        )),

                    expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                          Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: RatingBar(
                                unratedColor: Colors.black38.withOpacity(0.1),
                                initialRating: 2.25,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,

                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              )

                          ),
                      ],
                    ),
                    builder: (_, collapsed, expanded) {
                      return Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Expandable(
                          collapsed: collapsed,
                          expanded: expanded,
                          theme: const ExpandableThemeData(crossFadePoint: 0),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}