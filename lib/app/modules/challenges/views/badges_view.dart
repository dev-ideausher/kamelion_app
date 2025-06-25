import 'package:flutter/material.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';

class BadgesView extends StatelessWidget {
  const BadgesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.ksp),
      child: GridView.builder(
        itemCount: 6,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 items per row
          crossAxisSpacing: 10.ksp,
          mainAxisSpacing: 10.ksp,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: context.brandColor1Light,
              border: Border.all(color: context.brandBorderColor),
              borderRadius: BorderRadius.circular(14.ksp), // Rounded corners
            ),
            child: Column(
              children: [
                20.kheightBox,
                ClipOval(
                  child: Image.network(
                    'https://plus.unsplash.com/premium_photo-1714138490043-40cbd9d982dc?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8YmFkZ2V8ZW58MHx8MHx8fDA%3D',
                    width: 65.ksp,
                    height: 65.ksp,
                    fit: BoxFit.cover,
                  ),
                ),
                10.kheightBox,
                Text(
                  "Completing first Mental Gym",
                  style: TextStyleUtil.genSans400(
                    fontSize: 13.ksp,
                    color: context.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                6.kheightBox,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.ksp),
                  child: Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          minHeight: 5,
                          backgroundColor: Colors.grey[300],
                          value: 0.3,
                          color: context.brandColor1,
                        ),
                      ),
                      10.kwidthBox,
                      Text(
                        "1/5",
                        style: TextStyleUtil.genSans400(
                          fontSize: 10.ksp,
                          color: context.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
