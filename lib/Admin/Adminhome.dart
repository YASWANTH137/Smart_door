import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_door/Admin/Complaintreply.dart';
import 'package:smart_door/Admin/Addowner.dart';
import 'package:smart_door/Admin/Viewowner.dart';
import 'package:smart_door/Login.dart';
import 'package:smart_door/main.dart';
import 'package:smart_door/utils/api/viewownerapi.dart';


class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),
        title:  Text('ADMIN'),
        automaticallyImplyLeading: true,
        actions: [
      
         
        ],
        backgroundColor: Colors.blue,

      ),
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Adminhome(),
              SizedBox(height: 50.0),
              DeviceGrid(),
              SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }
}

class Adminhome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(16.0),
      // decoration: BoxDecoration(
      //   color: Color.fromARGB(255, 83, 151, 234),
      //   borderRadius: BorderRadius.circular(16.0),
      // ),
      // child: Padding(
      //   padding: const EdgeInsets.only(top: 30,bottom: 30),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       CircleAvatar(radius: 30,),
      //       Padding(
      //         padding: const EdgeInsets.only(left: 12,right: 12),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
        
                 
      //           ],
      //         ),
      //       ),
            
      //     ],
      //   ),
      // ),
    );
  }
}

class DeviceGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      shrinkWrap: true,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddOwner(),));
          },
          child: DeviceCard(
            icon: Icons.add,
            title: 'Add Owner',
            subtitle: '',
          ),
        ),
        
        InkWell(
          onTap: () async {
            List<Map<String, dynamic>> ownerdatas=
            await viewOwner();

            Navigator.push(context, MaterialPageRoute(builder: (context)=>Viewowner(ownerdatas: ownerdatas,),));
          },
          child: DeviceCard(
            icon: Icons.view_agenda_rounded,
            title: 'View Owner',
            subtitle: '',
          ),
        ),
        // SizedBox(
        //     height: 5,
        //                 ),
        InkWell(
           onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ComplaintReplyScreen(),));
          },
          child: DeviceCard(
            icon: Icons.warning,
            title: 'Complaint',
            subtitle: '',
          ),
        ),
         InkWell(
          onTap: ()async{
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.clear();
             Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
          },
           child: DeviceCard(
            icon: Icons.logout,
            title: 'Log Out',
            subtitle: '',
                   ),
         ),
      ],
    );
  }
}

class DeviceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  DeviceCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 48.0,
          ),
          SizedBox(height: 8.0),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}