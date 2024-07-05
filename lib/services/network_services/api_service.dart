// ignore_for_file: depend_on_referenced_packages
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;

import 'api_response.dart';

class ApiService {
  String baseUrl = "http://209.97.163.144:3001/";
  // String baseUrl = "https://api.xgroup.asia/";
  String apiPort = ":";
  String apiPrefix = "";

  Future<bool> checkInternet() async {
    if (kIsWeb) {
      return true;
    } else {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        }
      } on SocketException catch (e1,e2) {
        return false;
      }
      return false;
    }
  }

  String convertNetworkImage({required String orgPath}) {
    final result = (ApiService().baseUrl.replaceAll("/api/v1/", "") + apiPort + orgPath);
    return result;
  }

  Response convertHttpResponseToGetResponse({required http.Response response,required Request request}) {
    try {
      return Response(
        statusCode: response.statusCode,
        body: jsonDecode(response.body),
        bodyString: response.body,
        headers: response.headers,
        request: request
      );
    } catch(e1,e2){
      return Response(
        statusCode: response.statusCode,
        body: null,
        bodyString: response.body,
        headers: response.headers,
        request: request
      );
    }
  }

  Future<Response?> get(
      {required String endPoint,
      bool xNeedToken = false,
      bool xBaseUrlIncluded = true,
      int timeOutInSec = 100
      }) async {
    final xHasInternet = await checkInternet();
    print(Uri.parse(xBaseUrlIncluded ? "$baseUrl$apiPort$apiPrefix$endPoint" : endPoint).path);
    final Request request =  Request(
      url: Uri.parse(xBaseUrlIncluded ? "$baseUrl$apiPort$apiPrefix$endPoint" : endPoint),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
      }, method: 'GET',
    );

    if (xHasInternet) {
      final response = await http.get(
        Uri.parse(xBaseUrlIncluded ? "$baseUrl$apiPort$apiPrefix$endPoint" : endPoint),
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
          },
      );
      return convertHttpResponseToGetResponse(response: response,request: request);
    } else {
      return Response(
        request: request
      );
    }
  }

  Future<Response?> post(
      {required String endPoint,
      Map<String, dynamic> data = const {},
      bool xNeedToken = false,
      bool xBaseUrlIncluded = true}) async {
    final xHasInternet = await checkInternet();
    final Request request =  Request(
      url: Uri.parse(xBaseUrlIncluded ? "$baseUrl$apiPort$apiPrefix$endPoint" : endPoint),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
      }, method: 'GET',
    );

    if (xHasInternet) {
      final response = await http.post(
        Uri.parse(xBaseUrlIncluded ? "$baseUrl$apiPort$apiPrefix$endPoint" : endPoint),
        body: jsonEncode(data),
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
            "offset" : DateTime.now().timeZoneOffset.inMinutes.toString()
        },
      );
      return convertHttpResponseToGetResponse(response: response,request: request);
    } else {
      return Response(
          request: Request(
            url: Uri.parse(xBaseUrlIncluded ? "$baseUrl$apiPort$apiPrefix$endPoint" : endPoint),
            headers: {
              "accept": "*/*",
              "Content-Type": "application/json",
                  }, method: 'POST',
          )
      );
    }
  }

  Future<Response?> patch(
      {required String endPoint,
      bool xNeedToken = false,
      bool xBaseUrlIncluded = true}) async {
    final xHasInternet = await checkInternet();

    final Request request =  Request(
      url: Uri.parse(xBaseUrlIncluded ? "$baseUrl$apiPort$apiPrefix$endPoint" : endPoint),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
      }, method: 'GET',
    );

    if (xHasInternet) {
      final response = await http.patch(
        Uri.parse(xBaseUrlIncluded ? "$baseUrl$apiPort$apiPrefix$endPoint" : endPoint),
        headers: {
          "acccept": "*/*",
          "Content-Type": "application/json",
          },
      );
      return convertHttpResponseToGetResponse(response: response,request: request);
    } else {
      return Response(
          request: Request(
            url: Uri.parse(xBaseUrlIncluded ? "$baseUrl$apiPort$apiPrefix$endPoint" : endPoint),
            headers: {
              "accept": "*/*",
              "Content-Type": "application/json",
                  }, method: 'PATCH',
          )
      );
    }
  }

  Future<Response?> delete(
      {required String endPoint,
      bool xNeedToken = false,
      bool xBaseUrlIncluded = true}) async {
    final xHasInternet = await checkInternet();
    final Request request =  Request(
      url: Uri.parse(xBaseUrlIncluded ? "$baseUrl$apiPort$apiPrefix$endPoint" : endPoint),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
      }, method: 'GET',
    );

    if (xHasInternet) {
      final response = await http.delete(
        Uri.parse(xBaseUrlIncluded ? "$baseUrl$apiPort$apiPrefix$endPoint" : endPoint),
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
          },
      );

      return convertHttpResponseToGetResponse(response: response,request: request);
    } else {
      return Response(
          request: Request(
            url: Uri.parse(xBaseUrlIncluded ? "$baseUrl$apiPort$apiPrefix$endPoint" : endPoint),
            headers: {
              "accept": "*/*",
              "Content-Type": "application/json",
                  }, method: 'DELETE',
          )
      );
    }
  }

  Future<Response?> put(
      {required String endPoint,
      Map<String, dynamic> data = const {},
      bool xNeedToken = false,
      bool xBaseUrlIncluded = true}) async {
    final xHasInternet = await checkInternet();
    final Request request =  Request(
      url: Uri.parse(xBaseUrlIncluded ? "$baseUrl$apiPort$apiPrefix$endPoint" : endPoint),
      headers: {
        "accept": "*/*",
        "Content-Type": "application/json",
      }, method: 'GET',
    );
    if (xHasInternet) {
      final response = await http.put(
        Uri.parse(xBaseUrlIncluded ? "$baseUrl$apiPort$apiPrefix$endPoint" : endPoint),
        body: data,
        headers: {
          "accept": "*/*",
          "Content-Type": "application/json",
          },
      );
      return convertHttpResponseToGetResponse(response: response,request: request);
    } else {
      return Response(
          request: Request(
            url: Uri.parse(xBaseUrlIncluded ? "$baseUrl$apiPort$apiPrefix$endPoint" : endPoint),
            headers: {
              "accept": "*/*",
              "Content-Type": "application/json",
                  }, method: 'PUT',
          )
      );
    }
  }

  Future<Response?> formDataPost(
      {required String endPoint,
      Map<String, dynamic> data = const {},
      Map<String, dio.MultipartFile?> files = const {},
      bool xNeedToken = false,
      bool xBaseUrlIncluded = true}) async {
    final xHasInternet = await checkInternet();

    if (xHasInternet) {
      Response? response;
      try {
        dio.Dio dioClient = dio.Dio();
        dio.FormData formData = dio.FormData.fromMap({...data, ...files});
            var dioResponse = await dioClient.post(
            xBaseUrlIncluded ? "$baseUrl$apiPort$apiPrefix$endPoint" : endPoint,
            options: dio.Options(
              // contentType: 'multipart/form-data; boundary=<calculated when request is sent>',
              headers: <String, String>{
                "accept": "*/*",
                'Content-Type': 'multipart/form-data; boundary=<calculated when request is sent>'
              },
            ),
            data: formData);
        if (dioResponse.statusCode == 201) {
          response = Response(
            statusCode: 201,
            headers: {},
            body: dioResponse.data,
            statusText: "",
          );
        }
      } catch(e1,e2){
        if (e1 is dio.DioException) {
          try {
            response = Response(
                statusCode: e1.response!.statusCode,
                body: e1.response!.data,
                bodyString: e1.response!.data.toString());
          } catch(e1,e2){
            response = const Response(
                statusCode: 0, body: {}, bodyString: "Something went wrong!");
          }
        }
      }
      return response;
    } else {
        return Response(
          request: Request(
            url: Uri.parse(xBaseUrlIncluded ? "$baseUrl$apiPort$apiPrefix$endPoint" : endPoint),
            headers: {
              "accept": "*/*",
              "Content-Type": "application/json",
                  }, method: 'POST/FORM_DATA',
          )
      );
    }
  }

  ApiResponse validateResponse({
    required Response? response,
  }) {
    ApiResponse apiResponse = ApiResponse.getInstance();
    try{
      apiResponse.requestMethod = response!.request!.method;
      apiResponse.requestUrl = response.request!.url.path;
    }
    catch(e){
      null;
    }
    if (response == null) {
    } else {
      try {
        apiResponse.bodyString = response.bodyString;
        apiResponse.bodyData = response.body;
        apiResponse.statusCode = response.statusCode ?? 0;
        if(response.request!=null){
          apiResponse.requestMethod = response.request!.method;
          apiResponse.requestUrl = response.request!.url.path;
        }
        apiResponse.apiStatusCode = int.tryParse(response.body["_metadata"]["code"].toString())??0;
        if (response.statusCode! < 200 || response.statusCode! > 299) {
          apiResponse.xSuccess = false;
        } else if (response.body["_metadata"]["code"] >= 200 &&
            response.body["_metadata"]["code"] <= 299) {
          //success
          apiResponse.xSuccess = true;
        } else {
          apiResponse.xSuccess = false;
        }
        apiResponse.message = response.body["_metadata"]["message"] ?? "";
      } catch(e1,e2){
        if(response.request!=null){
        }
        apiResponse.message = e1.toString();
        if (response.statusCode == null) {
          // Get.off(()=> const LoginGreetingPage());
          // DialogService().showSnack(
          //     title: "Connection Time Out",
          //     message: "Unable to use the system now.Please contact the development team.");
        } else {
          // DialogService().showSnack(
          //     title: "Something went wrong",
          //     message:
          //         "Unable to use the system now.Please contact the development team.");
        }
      }
    }

    return apiResponse;
  }
}
