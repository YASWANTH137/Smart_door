import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:smart_door/utils/api/complaintapi.dart';
import 'package:smart_door/utils/api/loginapi.dart';
import 'package:smart_door/utils/api/replayapi.dart';

class ComplaintReplyScreen extends StatefulWidget {
  ComplaintReplyScreen({super.key});

  @override
  State<ComplaintReplyScreen> createState() => _ComplaintReplyScreenState();
}

class _ComplaintReplyScreenState extends State<ComplaintReplyScreen> {
  TextEditingController complaintcontroller = TextEditingController();
  TextEditingController replaycontroller = TextEditingController();
  List<Map<String, dynamic>> complaintdata = [];

  @override
  void initState() {
    getdata();
  }

  void getdata() async {
    complaintdata = await adminviewComplaint();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            // key: formKey,
            child: Column(children: <Widget>[
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
                                    image:
                                        AssetImage('assets/images/clock.png'))),
                          )),
                    ),
                    Positioned(
                      child: FadeInUp(
                          duration: Duration(milliseconds: 1600),
                          child: Container(
                            margin: EdgeInsets.only(top: 50),
                            child: Center(
                              child: Text(
                                "REPLAY",
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
                padding: EdgeInsets.all(20.0),
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
                                    color: Color.fromRGBO(143, 148, 251, .2),
                                    blurRadius: 20.0,
                                    offset: Offset(0, 10))
                              ]),
                          child: Container(
  // Set the height conditionally based on the length of complaintdata
  height: complaintdata.isEmpty ? 170 : complaintdata.length * 300,
  child: complaintdata.isEmpty
      ? Center(child: Text('No Complaints'))
      : ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => Column(
                    children: [
                      AlertDialog(
                        insetPadding: EdgeInsets.all(10),
                        title: Text('Send Replay'),
                        content: Column(
                          children: [
                            TextFormField(
                              controller: replaycontroller,
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: 'Type replay',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () async {
                                    Map<String, dynamic> data = {
                                      'logid':complaintdata[index]['C_id'],
                                      'replay': replaycontroller.text
                                    };

                                    await replaySend(data, context);
                                   
                                  },
                              child: Text('Send'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: Card(
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Name:'+complaintdata[index]['Name']??''),
                    ),
                    ListTile(
                      title: Text('Complaint:'),
                      subtitle: Text(complaintdata[index]['Complaints']),
                    ),
                    ListTile(
                      title: Text('Reply:'),
                      subtitle: Text(complaintdata[index]['Replay']),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: complaintdata.length,
        ),
),
                      )
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
