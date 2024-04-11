import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_door/Admin/Adminhome.dart';
import 'package:smart_door/Owner/Complaint.dart';
import 'package:smart_door/Owner/Ownerhome.dart';
import 'package:smart_door/utils/api/loginapi.dart';
import 'package:smart_door/utils/api/viewprofileapi.dart';
import 'package:smart_door/utils/commun/snackbar.dart';

Dio dio = Dio();

Future<void> complaintSend(data, context) async {
  try {
    Response response = await dio.post('$baseUrl/sendcomplaint', data: data);

    // Handle the response, you can use response.data to extract data from it.
    print(response.data);
    print(response.statusCode);

    if (response.statusCode == 200) {
      showCustomSnackBar(context, ' complaint send', Colors.green);
       Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>ComplaintScreen(),));
    } else {
      showCustomSnackBar(context, ' faied to send', Colors.red);
    }
  } catch (error) {
    print('Error: $error');
  }
}

//userview complaint


Future<List<Map<String, dynamic>>> viewComplaint() async {
  final String apiUrl = '$baseUrl/viewreplay?logid=$loginId'; // Replace baseUrl with your actual base URL

  try {
    Response response = await Dio().get(apiUrl);

    if (response.statusCode == 200) {
      // Handle successful response
      List<dynamic> responseData = response.data;
      List<Map<String, dynamic>> resultList = [];

      // Iterate over the list and convert each map to a single map
      for (int i = 0; i < responseData.length; i++) {
        Map<String, dynamic> dataMap = responseData[i];
        resultList.add(dataMap);
      }

      print(resultList);
      return resultList;
    } else {
      // Handle other status codes
      print('Failed with status code: ${response.statusCode}');
      throw Exception('Failed to fetch data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    // Handle Dio errors
    print('Error fetching data: $e');
    throw e;
  }
}

