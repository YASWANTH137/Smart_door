import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_door/Login.dart';
import 'package:smart_door/main.dart';
import 'package:smart_door/otpscreen.dart';
import 'package:smart_door/utils/api/loginapi.dart';
import 'package:smart_door/utils/commun/snackbar.dart';

Future<void> forgotPassword(email, context) async {
  try {
    Response response = await dio.post(
      '$baseUrl/forgot_password?email=$email',
      
    );

    // Handle the response, you can use response.data to extract data from it.
    print(response.data);
    print(response.statusCode);
    
    if (response.statusCode==200) {
     showCustomSnackBar(context, 'email send to $email', Colors.green);
     navigation(context, OtpScreen(email: email,));
    } else {
       showCustomSnackBar(context, 'failed to send  email', Colors.red);
    }
  } catch (error) {
    print('Error: $error');
  }
}

// post Otp and password
Future<void> sentOtpandPass( otp,password,context,email) async {
  try {
    // Create Dio instance
    Dio dio = Dio();

    // Send POST request
    Response response = await dio.post(
      '$baseUrl/checkotp?otp=$otp&password=$password&email=$email',
      
    );

    // Handle response
    if (response.statusCode == 200) {
      // Request was successful, handle the response data here
      print('Response: ${response.data}');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login(),));
    } else {
      // Request failed, handle error
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (error) {
    // Something went wrong, handle error
    print('Error: $error');
  }
}