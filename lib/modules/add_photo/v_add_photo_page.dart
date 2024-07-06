import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyhsms/app_data/app_colors.dart';
import 'package:pyhsms/app_data/app_constants.dart';
import 'package:pyhsms/modules/add_photo/c_add_photo_controller.dart';

class AddPhotoPage extends StatelessWidget {
  const AddPhotoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddPhotoController());
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add photo to our memo",
            style: TextStyle(
              fontWeight: FontWeight.w600
            ),
          ),
          centerTitle: true,
          elevation: 1,
        ),
        backgroundColor: AppColors.white,
        body: ValueListenableBuilder(
          valueListenable: controller.xLoading,
          builder: (context, xLoading, child) {
            if(xLoading){
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.orange.withOpacity(0.2)
                ),
                alignment: Alignment.center,
                child: CupertinoActivityIndicator(
                  color: AppColors.green,
                ),
              );
            }
            else{
              return SizedBox.expand(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: AppConstants.basePadding,
                      horizontal: AppConstants.basePadding
                  ),
                  child: LayoutBuilder(
                    builder: (a1, c1) {
                      final widget = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: controller.txtName,
                            decoration: const InputDecoration(
                              label: Text("Your name")
                            ),
                          ),
                          const SizedBox(height: 10,),
                          const Text("Upload your photo with us!"),
                          const SizedBox(height: 5,),
                          AspectRatio(
                            aspectRatio: 1,
                            child: ValueListenableBuilder(
                              valueListenable: controller.currentImage,
                              builder: (context, currentImage, child) {
                                return GestureDetector(
                                  onTap: () {
                                    controller.pickPhoto();
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.green
                                        ),
                                        color: AppColors.brown.withOpacity(0.4)
                                    ),
                                    alignment: Alignment.center,
                                    child: Builder(
                                      builder: (context) {
                                        if(currentImage==null){
                                          return const Icon(Icons.image_rounded);
                                        }
                                        else{
                                          if(kIsWeb){
                                            return Image.network(currentImage.path);
                                          }
                                          else{
                                            return Image.file(File(currentImage.path));
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: AppConstants.baseButtonHeightL,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.uploadPhoto();
                              },
                              child: const Text(
                                "Upload Now",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                      if(c1.maxHeight>c1.maxWidth){
                        //vertical
                        return Column(
                          children: [
                            widget
                          ],
                        );
                      }
                      else{
                        //horizontal
                        return Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: c1.maxHeight * 0.5,
                            child: widget,
                          ),
                        );
                      }

                    },
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}