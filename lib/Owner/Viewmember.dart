
import 'package:smart_door/Owner/updatemember.dart';
import 'package:smart_door/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smart_door/utils/api/loginapi.dart';

class Viewmember extends StatelessWidget {
  const Viewmember({super.key, required this.memberdatas});
final List<Map<String,dynamic>>memberdatas;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Members'),
      ),
      body: Column(
        children: [
           Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Action on search button pressed
                    },
                    icon: Icon(Icons.search),
                  ),
                ],
              ),
            ),
            SizedBox(height: 9,),
          Expanded(
            child: ListView.builder(
              
              itemBuilder: (context, index) {
                return Card(
                    child: ExpansionTile(
                      expandedAlignment: Alignment.bottomLeft,
                  title: Text(memberdatas[index]['Name']),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('$baseUrl/static/photo/${memberdatas[index]['Photo']}'),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [ 
Row(
  mainAxisAlignment: MainAxisAlignment.spaceAround,
  children: [
   IconButton(
                     onPressed: () {
                                                         navigation(context, Updatemember(memberdata: memberdatas,));
                                                       },
                    icon: Icon(Icons.update),
                  ),
                   IconButton(
                    onPressed: () {
                      // Action on search button pressed
                    },
                    icon: Icon(Icons.delete),
                  ),
],),

                    
            
            
            
                      ],),
                    )
                    
                  ],
                  
                ));
              },
              itemCount: memberdatas.length,
            ),
          ),
        ],
      ),
    );
  }
}