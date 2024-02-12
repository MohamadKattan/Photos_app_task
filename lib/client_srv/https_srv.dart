import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import '../utils/constants.dart';
import 'api_status.dart';

class HttpSrv {
  // get mehtod
  Future getData({required String url}) async {
    try {
      final getUrl = Uri.parse(url);
      final response = await http.get(getUrl);
      if (response.statusCode == 200) {
        final data = convert.jsonDecode(response.body) as Map<String, dynamic>;
        return Success(code: response.statusCode, response: data);
      } else {
        return Failur(
            errorResponse: errorResponseMsg, code: response.statusCode);
      }
    } catch (e) {
      return Failur(errorResponse: e.toString(), code: 500);
    }
  }
}
