
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_door/Owner/Ownerhome.dart';
import 'package:smart_door/utils/api/loginapi.dart';


  Dio dio = Dio();

 Future<void> registerMember(Map<String, dynamic> data, File image,context) async {
  final String apiUrl = '$baseUrl/addmember';

  try {
    FormData formData = FormData();

    // Add fields from the data map
    data.forEach((key, value) {
      formData.fields.add(MapEntry(key, value.toString()));
    });

    // Add the image file
    formData.files.add(MapEntry(
        'image',
        await MultipartFile.fromFile(
          image.path,
          // filename: 'img.jpg',
        )));

    Response response = await Dio().post(apiUrl, data: formData);

    print(response.statusCode);
    if (response.statusCode==200) {
      if (response.data['task']=='success') {

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OwnerHome(profileData: profiledata,)));
        
      }
      
    }
    print(response);
  } catch (e) {
    print(e);
    throw e;
  }
}

