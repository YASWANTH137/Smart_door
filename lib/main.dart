import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_door/Admin/Addowner.dart';
import 'package:smart_door/Admin/Adminhome.dart';
import 'package:smart_door/Admin/Complaintreply.dart';
import 'package:smart_door/Login.dart';
import 'package:smart_door/Owner/Addmember.dart';
import 'package:smart_door/Owner/Ownerhome.dart';
import 'package:smart_door/utils/api/loginapi.dart';
import 'package:smart_door/utils/api/viewprofileapi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: Login(),
      home: FutureBuilder<String>(
        future: check(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // or any loading indicator
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Login();
          } else {
            final String type = snapshot.data ?? '';
            if (type == 'admin') {
              return AdminHome();
            } else if (type == 'owner'){
              
              //
              return OwnerHome(profileData:profiledata ,);
            }else{
              return Login();
            }
          }
        },
      ),
    );
  }
}

Future<String> check() async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String type = prefs.getString('type') ?? '';
    loginId = prefs.getInt('lid') ?? 0;

    profiledata= await viewProfile();
    print('checked');
    return type;
  } catch (e) {
    print(e.toString());
    return '';
  }
}

void navigation(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}
