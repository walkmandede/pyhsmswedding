import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pyhsms/app_data/app_colors.dart';
import 'package:pyhsms/app_data/app_constants.dart';

class CongratulationPage extends StatelessWidget {
  final String name;
  final String image;
  const CongratulationPage({super.key,required this.name,required this.image});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
      child: Scaffold(
        backgroundColor: AppColors.brown.withOpacity(0.2),
        appBar: AppBar(
        ),
        body: SizedBox.expand(
          child: LayoutBuilder(
            builder: (a1, c1) {
              bool xVertical = c1.maxHeight>c1.maxWidth;
              if(xVertical){
                return Stack(
                  children: [
                    Image.asset(
                      'assets/images/con_bg.jpg',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.fill,
                    ),
                    SizedBox.expand(
                      child: LayoutBuilder(
                        builder: (a1, c1) {
                          return eachWidget(c1);
                        },
                      ),
                    )
                  ],
                );
              }
              else{
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: double.infinity,
                      child: AspectRatio(
                        aspectRatio: 1200/1680,
                        child: SizedBox(
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/images/con_bg.jpg',
                                fit: BoxFit.cover,
                              ),
                              LayoutBuilder(
                                builder: (a1, c1) {
                                  return eachWidget(c1);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }
            },
          )
        ),
      ),
    );
  }

  Widget eachWidget(BoxConstraints c1){
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: c1.maxWidth * 0.15,
          vertical: c1.maxHeight * 0.1
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            child: Text(
              "Thank You ...., Dear $name ",
              style: TextStyle(
                color: AppColors.green,
                fontWeight: FontWeight.w600,
                fontSize: AppConstants.fontSizeXL,
              ),
              maxLines: 1,
            ),
          ),
          SizedBox(height: c1.maxHeight * 0.025,),
          FittedBox(
            child: Text(
              "Thank you so much for attending our wedding\nand sharing in the joy of our special day.\nYour presence meant the world to us.",
              style: TextStyle(
                  color: AppColors.orange,
                  fontWeight: FontWeight.w600,
                  fontSize: AppConstants.fontSizeM
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
            ),
          ),
          SizedBox(height: c1.maxHeight * 0.025,),
          SizedBox(
            height: c1.maxHeight * 0.25,
            child: Image.network(image),
          ),
          SizedBox(height: c1.maxHeight * 0.025,),
          FittedBox(
            child: Text(
              "We are especially grateful for\nyour participation in our gallery session.\nThe photo you uploaded with us \nadds a cherished memory to our web page,\nallowing us to relive the magic of the day.",
              style: TextStyle(
                  color: AppColors.orange,
                  fontWeight: FontWeight.w600,
                  fontSize: AppConstants.fontSizeXL
              ),
              textAlign: TextAlign.center,
              maxLines: 5,
            ),
          ),
          SizedBox(height: c1.maxHeight * 0.05,),
          Text(
            "With heartfelt gratitude,",
            style: TextStyle(
                color: AppColors.green,
                fontWeight: FontWeight.w600,
                fontSize: AppConstants.fontSizeS
            ),
            textAlign: TextAlign.end,
          ),
          Text(
            "Phyo Ye & Shwe Hmone",
            style: TextStyle(
                color: AppColors.green,
                fontWeight: FontWeight.w600,
                fontSize: AppConstants.fontSizeS
            ),
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }

}
