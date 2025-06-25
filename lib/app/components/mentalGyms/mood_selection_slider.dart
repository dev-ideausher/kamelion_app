import 'package:flutter/material.dart';
import 'package:kamelion/app/components/common_image_view.dart';
import 'package:kamelion/app/constants/image_constant.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/responsive_size.dart';
import 'package:kamelion/app/services/text_style_util.dart';

class ImageSliderSelector extends StatefulWidget {
  const ImageSliderSelector({super.key});

  @override
  State<ImageSliderSelector> createState() => _ImageSliderSelectorState();
}

class _ImageSliderSelectorState extends State<ImageSliderSelector> {
  late PageController _pageController;
  int _currentPage = 2;

  final List<String> imagePaths = [
    ImageConstant.unHappyMood,
    ImageConstant.sadMood,
    ImageConstant.normalMood,
    ImageConstant.goodMood,
    ImageConstant.happyMood,
  ];

  final List<String> moodsName = ["Unhappy", "Sad", "Normal", "Good", "Happy"];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: 0.23, // controls how much of other items are visible
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildImageItem(int index) {
    bool isSelected = index == _currentPage;
    return AnimatedContainer(
      // padding: EdgeInsets.symmetric(horizontal: 3/.ksp),
      duration: const Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(horizontal: 10.ksp),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(50),
      ),

      child: Column(
        children: [
          CommonImageView(
            svgPath: imagePaths[index],
            fit: BoxFit.fill,
            height: 50.ksp,
            width: 90.ksp,
          ),
          5.kheightBox,
          Text(
            moodsName[index],
            style: TextStyleUtil.genSans500(
              fontSize: 10.ksp,
              color: context.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.ksp,
      // width: 9.ksp,
      child: PageView.builder(
        controller: _pageController,
        itemCount: imagePaths.length,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          return _buildImageItem(index);
        },
      ),
    );
  }
}
