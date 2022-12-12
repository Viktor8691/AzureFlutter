import 'dart:convert';
import 'dart:io';

import 'package:workspace/data/local/common.dart';
import 'package:workspace/data/remote/app_exception.dart';
import 'package:workspace/data/remote/network/base_api_service.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiService {

  @override
  Future getResponse(String url) async{
    dynamic responseJson;
    try {
      final header = {
        'Content-Type': 'application/json',
        'Accept' : 'application/json',
        'OData-MaxVersion' : '4.0',
        'OData-Version' : '4.0',
        'Authorization' : 'Bearer ${accessToken}'
      };

      final response = await http.get(Uri.parse(baseUrl + url), headers: header);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;

      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException('Error occurred while communication with server' + ' with status code: ${response.statusCode}');
    }
  }

}
