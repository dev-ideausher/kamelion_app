import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kamelion/app/models/mental_gym_category_model.dart';
import 'package:kamelion/app/modules/community/controllers/community_controller.dart';
import 'package:kamelion/app/services/dialog_helper.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
import 'package:kamelion/app/services/snackbar.dart';
import 'package:kamelion/generated/locales.g.dart';

class CreateCommunityController extends GetxController {
  //TODO: Implement CreateCommunityController

  final count = 0.obs;
  final nameController = TextEditingController();
  RxString communityType = "".obs;
  String uploadedImage = "";
  RxBool enabelCreateBotton = false.obs;
  Rx<File> croppedCommunityImage = Rx<File>(File(""));
  // String? selectedCategory;
  MentalGymCategoryModel? selectedCategory;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<void> pickAndCropImage() async {
    DialogHelper.showLoading();
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 6, ratioY: 3),
        // cropStyle: CropStyle.rectangle,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            lockAspectRatio: true,
            hideBottomControls: true,
            // initAspectRatio: CropAspectRatioPreset.square,
          ),
          IOSUiSettings(title: 'Crop Image', aspectRatioLockEnabled: true),
        ],
      );

      if (croppedFile != null) {
        croppedCommunityImage.value = File(croppedFile.path);
      }
      print(croppedCommunityImage.value.path);
    }
    DialogHelper.hideDialog();
    checkFormValidity();
  }

  void checkFormValidity() {
    final name = nameController.text.trim();
    final isNameValid = name.isNotEmpty;
    final imageValid = croppedCommunityImage.value.path != "";
    final categoryValid = selectedCategory != null;
    enabelCreateBotton.value = isNameValid && imageValid && categoryValid;

    update();
  }

  Future<void> uploadImage() async {
    if (croppedCommunityImage.value.path.isNotEmpty) {
      try {
        var response = await APIManager.uploadFile(
          filePath: croppedCommunityImage.value.path,
        );
        if (response.data['status']) {
          uploadedImage = response.data['data'][0]['url'];
        }
      } on DioException catch (dioError) {
        showMySnackbar(msg: dioError.message ?? "");
        DialogHelper.hideDialog();
      } catch (e) {
        showMySnackbar(msg: e.toString());
      }
    }
  }

  void createCommunity() async {
    if (enabelCreateBotton.value) {
      try {
        var response;
        DialogHelper.showLoading();
        await uploadImage();
        if (uploadedImage.isNotEmpty) {
          response = await APIManager.createCommunity(
            category: selectedCategory!.sId ?? "",
            communityName: nameController.text,
            imageUrl: uploadedImage,
          );

          if (response.data['data'] != null && response.data['status']) {
            Get.back();
            Get.back();
            DialogHelper.hideDialog();
            showMySnackbar(msg: response.data['message']);
            await Get.find<CommunityController>().getYourCommunities();
            update();
          } else {
            showMySnackbar(msg: response.data['message'] ?? "");
            DialogHelper.hideDialog();
          }
          update();
        }
        // return;
      } on DioException catch (dioError) {
        showMySnackbar(msg: dioError.message ?? "");
        DialogHelper.hideDialog();
      } catch (e) {
        showMySnackbar(msg: e.toString());
        DialogHelper.hideDialog();
      }
    }
  }
}
