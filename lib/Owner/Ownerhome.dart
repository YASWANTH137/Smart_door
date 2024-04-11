import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_door/Admin/Addowner.dart';
import 'package:smart_door/Admin/Viewowner.dart';
import 'package:smart_door/Login.dart';
import 'package:smart_door/Owner/Addmember.dart';
import 'package:smart_door/Owner/Complaint.dart';
import 'package:smart_door/Owner/Profile.dart';
import 'package:smart_door/Owner/Viewmember.dart';
import 'package:smart_door/main.dart';
import 'package:smart_door/utils/api/loginapi.dart';
import 'package:smart_door/utils/api/viewmemberapi.dart';


class OwnerHome extends StatelessWidget {
  final profileData;

  const OwnerHome({super.key, this.profileData});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),
        title:  Text('OWNER'),
        automaticallyImplyLeading: true,
        actions: [
      
         
        ],
        backgroundColor: Colors.blue,

      ),
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  
                InkWell(
                  onTap: ()
                  { 
                    navigation(context, ProfileScreen(profiledata: profileData,));
                  },
                  child: Ownerhome(profiledata: profileData,)),
                SizedBox(height: 30.0),
                DeviceGrid(),
                // SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Ownerhome extends StatelessWidget {
  final profiledata;

  const Ownerhome({super.key, this.profiledata});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 83, 151, 234),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 30,bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(radius: 30,backgroundImage: NetworkImage('$baseUrl/static/photo/${profiledata[0]['Photo']}'),),
            Padding(
              padding: const EdgeInsets.only(left: 12,right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                  profiledata[0]['Name'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    profiledata[0]['Email'],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                 
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}

class DeviceGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics:NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      shrinkWrap: true,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Addmember(),));
          },
          child: DeviceCard(
            icon: Icons.add,
            title: 'Add Members',
            subtitle: '',
          ),
        ),
        
        InkWell(
          onTap: () async {
            List<Map<String, dynamic>> memberdatas=
            await viewMember();

            Navigator.push(context, MaterialPageRoute(builder: (context)=>Viewmember(memberdatas: memberdatas,),));
          },
          child: DeviceCard(
            icon: Icons.view_agenda_rounded,
            title: 'View Members',
            subtitle: '',
          ),
        ),

         InkWell(
          // onTap: () {
          //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Register(),));
          // },
          child: DeviceCard(
            icon: Icons.view_agenda_rounded,
            title: 'View Accessed',
            subtitle: '',
          ),
        ),
        
        InkWell(
          // onTap: () {
          //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Viewowner(),));
          // },
          child: DeviceCard(
            icon: Icons.door_back_door_rounded,
            title: 'Operate Door',
            subtitle: '',
          ),
        ),

         InkWell(
          // onTap: () {
          //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Register(),));
          // },
          child: DeviceCard(
            icon: Icons.light,
            title: 'Operate Light',
            subtitle: '',
          ),
        ),
        
        InkWell(
          // onTap: () {
          //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Viewowner(),));
          // },
          child: DeviceCard(
            icon: Icons.mode_fan_off_outlined,
            title: 'Operate Fan',
            subtitle: '',
          ),
        ),
        
        InkWell(
          onTap: () {
           Navigator.push(context, MaterialPageRoute(builder: (context)=>ComplaintScreen(),));
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