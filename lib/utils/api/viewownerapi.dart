import 'package:dio/dio.dart';
import 'package:smart_door/utils/api/loginapi.dart';

Future<List<Map<String, dynamic>>> viewOwner() async {
  final String apiUrl = '$baseUrl/viewowner'; // Replace baseUrl with your actual base URL

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
