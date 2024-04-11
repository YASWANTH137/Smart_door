
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smart_door/Admin/Adminhome.dart';
import 'package:smart_door/Owner/Ownerhome.dart';
import 'package:smart_door/Owner/Profile.dart';
import 'package:smart_door/utils/api/loginapi.dart';
import 'package:smart_door/utils/api/viewprofileapi.dart';


  Dio dio = Dio();

 Future<void> updateMember(Map<String, dynamic> data,  image,context) async {
  final String apiUrl = '$baseUrl/editmember';

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

        profiledata = await viewProfile();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => OwnerHome(
                                                      // profiledata: profiledata,
                                                    ),
                                                  ),
                                                );
        
      }
      
    }
    print(response);
  } catch (e) {
    print(e);
    throw e;
  }
}

