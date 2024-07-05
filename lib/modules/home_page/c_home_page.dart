import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyhsms/services/network_services/api_end_points.dart';
import 'package:pyhsms/services/network_services/api_response.dart';
import 'package:pyhsms/services/network_services/api_service.dart';

class HomePageController extends GetxController{

  ValueNotifier<List<String>> imagesList = ValueNotifier([]);
  ValueNotifier<bool> xLoading = ValueNotifier(false);

  @override
  void onInit() {
    super.onInit();
    initLoad();
  }

  Future<void> initLoad() async{
    fetchPhoto();
  }

  Future<void> fetchPhoto() async{
    xLoading.value = true;
    await Future.delayed(const Duration(seconds: 3));
    try{
      // Response? response = await ApiService().get(endPoint: "http://192.168.100.32:3001/",xBaseUrlIncluded: false);
      Response? response = await ApiService().get(endPoint: "http://209.97.163.144:3001/",xBaseUrlIncluded: false);
      ApiResponse apiResponse = ApiService().validateResponse(response: response);
      print(apiResponse.bodyData);
      print(apiResponse.statusCode);
      Iterable iterable = apiResponse.bodyData??[];
      imagesList.value = iterable.map((e) => e.toString(),).toList();
      // imagesList.value = iterable.map((e) {
      //   try{
      //     return e['path'].toString();
      //   }
      //   catch(e){
      //     return "";
      //   }
      // },).toList();
    }
    catch(e){
      print(e);
      null;
    }
    xLoading.value = false;
  }

}