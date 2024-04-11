import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:smart_door/utils/api/complaintapi.dart';
import 'package:smart_door/utils/api/loginapi.dart';

class ComplaintScreen extends StatefulWidget {
   ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  TextEditingController complaintcontroller=TextEditingController();
  List <Map<String,dynamic>> complaintdata=[];

  @override
  void initState() {
    
    
    
    getdata();
  }

  void getdata()async{
complaintdata=await viewComplaint();
setState(() {
  
});
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: ElevatedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => Column(
                      children: [
                        AlertDialog(
                          insetPadding: EdgeInsets.all(10),
                          title: Text('Sent Complaint'),
                          content: Column(
                            children: [
                              TextFormField(
                                controller:complaintcontroller ,
                                maxLines: null,
                                decoration: InputDecoration(
                                    hintText: 'Add Comments',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    Map<String, dynamic> data = {
                                      'logid':loginId,
                                      'complaint': complaintcontroller.text
                                    };

                                    await complaintSend(data, context);
                                   
                                  },
                                  child: Text('sent'))
                            ],
                          ),
                        ),
                      ],
                    ));
          },
            child: Text('Sent Complaint')),
              backgroundColor: Colors.white,
          body: SingleChildScrollView(
              child: Container(
            child: Form(
              // key: formKey,
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
                                margin: EdgeInsets.only(top: 50),
                                child: Center(
                                  child: Text(
                                    "COMPLAINT",
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
                                        color:
                                            Color.fromRGBO(143, 148, 251, .2),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10))
                                  ]),
                              child: 
                              Container(
                               height: complaintdata.isEmpty ? 170 : complaintdata.length * 170,
  child: complaintdata.isEmpty
      ? Center(child: Text('No replays'))
      : ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('Complaint:'),
                          subtitle: Text(complaintdata[index]['Complaints']),
                        ),
                        ListTile(
                          title: Text('Replay:'),
                          subtitle: Text(complaintdata[index]['Replay']),
                        )
                      ],
                    ),
                  );
                },
                itemCount: complaintdata.length,
              ),
            )
                                  ),
                    )],
                    ),
                  )
                  ]),
              ),
            ),
          ),
        );
        
        
  }
 

  
}




















