
import 'package:smart_door/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smart_door/utils/api/loginapi.dart';

class Viewowner extends StatelessWidget {
  const Viewowner({super.key, required this.ownerdatas});
final List<Map<String, dynamic>> ownerdatas;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Owners'),
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
                  title: Text(ownerdatas[index]['Name']),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('$baseUrl/static/photo/${ownerdatas[index]['Photo']}'),

                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [ 
                      Text('Email : '+ownerdatas[index]['Email']),
                      Text('DOB : '+ownerdatas[index]['Date of birth']),
                       Text('Gender : '+ownerdatas[index]['Gender']),
                      Text('Phone : '+ownerdatas[index]['Phone'].toString()),
                      Text('Place : '+ownerdatas[index]['Place']),
                      ],),
                    )
                    
                  ],
                  
                ));
              },
              itemCount: ownerdatas.length,
            ),
          ),
        ],
      ),
    );
  }
}