import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pyhsms/modules/home_page/c_home_page.dart';
import 'package:pyhsms/modules/home_page/v_home_page.dart';
import 'package:pyhsms/services/network_services/api_response.dart';
import 'package:dio/dio.dart' as dio;
import 'package:pyhsms/services/network_services/api_service.dart';

class AddPhotoController extends GetxController{

  ValueNotifier<XFile?> currentImage = ValueNotifier(null);
  ValueNotifier<bool> xLoading = ValueNotifier(false);
  
  @override
  void onInit() {
    super.onInit();
    initLoad();
  }
  
  Future<void> initLoad() async{
    
  }

  Future<void> pickPhoto() async{
    xLoading.value = true;
    try{
      final result = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(result!=null){
        currentImage.value = result;
      }
    }
    catch(e){
      null;
    }
    xLoading.value = false;
  }

  Future<void> uploadPhoto() async{
    xLoading.value = true;
    try{

      if(currentImage.value != null){
        print(currentImage.value!.path);
        print((await currentImage.value!.readAsBytes() as List<int>).length);
        Response? response = await ApiService().formDataPost(
            endPoint: "http://209.97.163.144:3001/upload",
            // endPoint: "http://192.168.100.32:3001/upload",
            xBaseUrlIncluded: false,
            files: {
              "file" : currentImage.value==null?null:dio.MultipartFile.fromBytes(
                await currentImage.value!.readAsBytes() as List<int>,
                filename: "${currentImage.value!.path}.${currentImage.value!.mimeType??""}",
                contentType: dio.DioMediaType(currentImage.value!.mimeType??"",currentImage.value!.mimeType??"")
              )
            }
        );
        final apiResponse = ApiService().validateResponse(response: response);
        print(apiResponse.statusCode);
        print(apiResponse.bodyData);
        if(apiResponse.statusCode == 200 || apiResponse.statusCode == 201){
          HomePageController homePageController = Get.find();
          homePageController.initLoad();
          Get.back();
        }
        else{
          Get.showSnackbar(const GetSnackBar(
            title: "Unable to upload photo!",
            message: "Something went wrong!",
            duration: const Duration(seconds: 2),
          ));
        }
      }
      else{
        Get.showSnackbar(const GetSnackBar(
          title: "Unable to upload photo!",
          message: "Please pick a photo to upload",
          duration: const Duration(seconds: 2),
        ));
      }
    }
    catch(e){
      print(e);
      null;
    }
    xLoading.value = false;
  }
  
}