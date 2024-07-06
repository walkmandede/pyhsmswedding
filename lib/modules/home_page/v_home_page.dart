import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyhsms/app_data/app_colors.dart';
import 'package:pyhsms/app_data/app_constants.dart';
import 'package:pyhsms/main.dart';
import 'package:pyhsms/modules/add_photo/v_add_photo_page.dart';
import 'package:pyhsms/modules/home_page/c_home_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomePageController());
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.brown,
          elevation: 1,
          title: const Text(
            "Phyo Ye & Shwe Hmone",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Get.to(()=> const AddPhotoPage());
          },
          backgroundColor: AppColors.brown,
          label: const Text(
            "Join our gallery",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black
            ),
          ),
          icon: const Icon(Icons.image_rounded,color: Colors.black,),
        ),
        body: SizedBox.expand(
          child: ValueListenableBuilder(
            valueListenable: controller.xLoading,
            builder: (context, xLoading, child) {
              if(xLoading){
                return Center(
                  child: CupertinoActivityIndicator(color: AppColors.orange,),
                );
              }
              else{
                return ValueListenableBuilder(
                  valueListenable: controller.imagesList,
                  builder: (context, imagesList, child) {
                    if(imagesList.isEmpty){
                      return const Center(
                        child: Text(
                          "No Images Yet!",
                          style: TextStyle(
                          ),
                        ),
                      );
                    }
                    else{
                      return LayoutBuilder(
                        builder: (a1, c1) {
                          bool xVertical = c1.maxHeight>c1.maxWidth;
                          return GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: xVertical?2:4,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10
                            ),
                            padding: EdgeInsets.only(
                                left: AppConstants.basePadding,
                                right: AppConstants.basePadding,
                                top: AppConstants.basePadding,
                                bottom: AppConstants.basePadding + (xVertical?Get.height * 0.2:0)
                            ),
                            itemCount: imagesList.length,
                            itemBuilder: (context, index) {
                              final image = imagesList[index];
                              Image widget = Image.network(
                                image,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(Icons.error_rounded),
                                  );
                                },
                              );
                              return GestureDetector(
                                onTap: () {
                                  Get.dialog(
                                      Scaffold(
                                        appBar: AppBar(),
                                        backgroundColor: Colors.transparent,
                                        body: SizedBox.expand(
                                          child: Center(
                                            child: SizedBox(
                                              width: Get.width,
                                              child: widget,
                                            ),
                                          ),
                                        ),
                                      ),
                                      barrierColor: AppColors.orange.withOpacity(0.9)
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius),
                                  child: AspectRatio(
                                    aspectRatio: 1/1,
                                    child: widget,
                                  ),
                                ),
                              );
                            },
                          );
                          return ListView.separated(
                            scrollDirection: xVertical?Axis.vertical:Axis.horizontal,
                            restorationId: "11",
                            shrinkWrap: true,
                            padding: EdgeInsets.only(
                                left: AppConstants.basePadding,
                                right: AppConstants.basePadding,
                                top: AppConstants.basePadding,
                                bottom: AppConstants.basePadding + (xVertical?Get.height * 0.2:0)
                            ),
                            itemCount: imagesList.length,
                            itemBuilder: (context, index) {
                              final image = imagesList[index];
                              Image widget = Image.network(
                                image,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(Icons.error_rounded),
                                  );
                                },
                              );
                              return GestureDetector(
                                onTap: () {
                                  Get.dialog(
                                    Scaffold(
                                      appBar: AppBar(),
                                      backgroundColor: Colors.transparent,
                                      body: SizedBox.expand(
                                        child: Center(
                                          child: SizedBox(
                                            width: Get.width,
                                            child: widget,
                                          ),
                                        ),
                                      ),
                                    ),
                                    barrierColor: AppColors.orange.withOpacity(0.9)
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(AppConstants.baseBorderRadius),
                                  child: AspectRatio(
                                    aspectRatio: 1/1,
                                    child: widget,
                                  ),
                                ),
                              );
                            }, separatorBuilder: (BuildContext context, int index) { return const Padding(padding: EdgeInsets.all(10)); },
                          );
                          return GridView.builder(
                            padding: EdgeInsets.only(
                                left: AppConstants.basePadding,
                                right: AppConstants.basePadding,
                                top: AppConstants.basePadding,
                                bottom: AppConstants.basePadding + Get.height * 0.2
                            ),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: xVertical?2:5,
                                childAspectRatio: 9/16,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10
                            ),
                            itemCount: imagesList.length,
                            itemBuilder: (context, index) {
                              final image = imagesList[index];
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                      color: AppColors.orange.withOpacity(0.4)
                                  ),
                                  alignment: Alignment.center,
                                  child: Image.network(
                                    image,
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                        child: Icon(Icons.error_rounded),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}