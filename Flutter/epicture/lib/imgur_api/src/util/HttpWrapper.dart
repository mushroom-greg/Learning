import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

class HttpWrapper {
  final String _clientId;
  final String _clientSecret;

  final String _baseUrl = "api.imgur.com";
  final String _version = "/3";

  HttpWrapper(this._clientId, this._clientSecret);

  Future<ResponseWrapper> createRequest(String method, String path,
      {Map<String, dynamic> body,
      Map<String, String> params,
      bool auth: false}) async {
    var uri = Uri.https(_baseUrl, _version + path, params);
    var req = new http.Request(method, uri);

    req.body = jsonEncode(body);
    if (!auth)
      req.headers["Authorization"] = "Client-ID $_clientId";
    else
      req.headers["Authorization"] = "Bearer $_clientSecret";

    var res = await req.send();
    var str = await res.stream.bytesToString();

    if (res.statusCode > 200)
      throw new Exception("HTTP EXCEPTION: ${res.statusCode}");

    return new ResponseWrapper(jsonDecode(str), res.statusCode);
  }
}

class ResponseWrapper {
  Map<String, dynamic> response;
  int code;

  ResponseWrapper(this.response, this.code);
}
