import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:productsearch_magic/utils/constants.dart';

import 'package:productsearch_magic/data/custom_exception.dart';

class ApiService {
  final Map<String, String> _headers = {
    'Accept': 'application/json',
  };


  Future<dynamic> getData(String url, {Map<String, dynamic>? params}) async {
    dynamic responseJson;
    try {
      final response = await http.get(
        Uri.https(AppConstants.baseUrl, url, params),
        headers: _headers,
      );
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  
  dynamic _response(http.Response response) {
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body.toString());
      return responseJson;
    } else {
      final responseJson = json.decode(response.body.toString());
      throwException(responseJson);
    }
  }
}

void throwException(Map<String, dynamic> data) {
  if (data.containsKey('errors')) {
    List message = [];

    if (data['errors'].runtimeType.toString().contains('Map')) {
      data['errors'].forEach(
        (key, value) {
          if (value.runtimeType.toString().contains('List')) {
            value.forEach((e) => message.add(e));
          } else {
            message.add(value);
          }
        },
      );
    } else {
      message.add(data['errors']);
    }
    throw Exception(message.join('\n'));
  } else if (data.containsKey('message')) {
    throw Exception(data['message']);
  } else {
    throw Exception('Error');
  }
}
