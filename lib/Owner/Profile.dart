import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:smart_door/Owner/Profileupdate.dart';
import 'package:smart_door/customwidgets/Textfield.dart';
import 'package:smart_door/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_door/utils/api/loginapi.dart';



class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key,required this.profiledata});
  final profiledata;
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/background.png'),
                            fit: BoxFit.fill)),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 30,
                          width: 80,
                          height: 200,
                          child: FadeInUp(
                              duration: Duration(seconds: 1),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/light-1.png'))),
                              )),
                        ),
                        Positioned(
                          left: 140,
                          width: 80,
                          height: 150,
                          child: FadeInUp(
                              duration: Duration(milliseconds: 1200),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/light-2.png'))),
                              )),
                        ),
                        Positioned(
                          right: 40,
                          top: 40,
                          width: 80,
                          height: 150,
                          child: FadeInUp(
                              duration: Duration(milliseconds: 1300),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/clock.png'))),
                              )),
                        ),
                        Positioned(
                          child: FadeInUp(
                              duration: Duration(milliseconds: 1600),
                              child: Container(
                                margin: EdgeInsets.only(top: 90),
                                child: Center(
                                  child: Text(
                                    "PROFILE",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        FadeInUp(
                            duration: Duration(milliseconds: 1800),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Color.fromRGBO(143, 148, 251, 1)),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color.fromRGBO(143, 148, 251, .2),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10))
                                  ]),
                               child: Column(children: [
                                 Align(
                                  alignment: Alignment.bottomRight,
                                   child: IconButton(
                                    
                                                       onPressed: () {
                                                         navigation(context, UpdateScreen(profiledata: profiledata,));
                                                       },
                                                       icon: Icon(Icons.update_outlined),
                                                     ),
                                 ),
            CircleAvatar(radius: 50,backgroundImage: NetworkImage('$baseUrl/static/photo/${profiledata[0]['Photo']}'),),
            Text(profiledata[0]['Name']),
             SizedBox(
              height: 30,
             ),
            Card(child: Column(
              children: [
                ListTile(title: Text('Name: '+profiledata[0]['Name']),),
                 ListTile(title: Text('DOB: '+profiledata[0]['Date of birth'].toString()),),
                  ListTile(title: Text('Gender: '+profiledata[0]['Gender']),),
                 ListTile(title: Text('Email: '+profiledata[0]['Email']),),
                   ListTile(title: Text('Phone: '+profiledata[0]['Phone'].toString()),),
              ],
            )),
            
            
          ],),

                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
