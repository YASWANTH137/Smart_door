import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_door/Admin/Adminhome.dart';
import 'package:smart_door/Owner/Ownerhome.dart';
import 'package:smart_door/utils/api/viewprofileapi.dart';
import 'package:smart_door/utils/commun/snackbar.dart';

Dio dio = Dio();
int loginId = 0;
String baseUrl = 'http://192.168.1.51:5000';
List<Map<String, dynamic>>profiledata=[];

Future<void> loginUser(Username, Password, context) async {
  try {
    Response response = await dio.post(
      '$baseUrl/logincheck?Username=$Username&Password=$Password',
      // data: {
      //   'username': username,
      //   'password': password,
      // },
    );

    // Handle the response, you can use response.data to extract data from it.
    print(response.data);
    print(response.statusCode);
    int lid = response.data['lid'] ?? "";
    String status = response.data['task'] ?? "";
    String type = response.data['type'] ?? "";
    if (status == 'success') {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('lid', lid);
      prefs.setString('type', type);
      print('shared pref stored');

      loginId = await prefs.getInt('lid')!;
      print(loginId);

      if (type == 'admin') {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AdminHome()));
      } else {
        profiledata=await viewProfile();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => OwnerHome(profileData:profiledata ,)));
      }
    } else {
      showCustomSnackBar(context, 'Login faied', Colors.red);
    }
  } catch (error) {
    print('Error: $error');
  }
}
