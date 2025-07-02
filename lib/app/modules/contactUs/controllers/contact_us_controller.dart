import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/services/dialog_helper.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
import 'package:kamelion/app/services/snackbar.dart';

class ContactUsController extends GetxController {
  //TODO: Implement ContactUsController

  final count = 0.obs;
  TextEditingController postContentController = TextEditingController();
  RxBool enableButton = false.obs;
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

  void checkFormValidity() {
    enableButton.value = (postContentController.text != "");
  }

  void createPost() async {
    if (enableButton.value) {
      try {
        var response;
        DialogHelper.showLoading();

        response = await APIManager.contactUsSubmit(
          desc: postContentController.text,
        );

        if (response.data['status']) {
          Get.back();
          DialogHelper.hideDialog();
          Get.back();
          showMySnackbar(msg: response.data['message']);
        } else {
          showMySnackbar(msg: response.data['message'] ?? "");
          DialogHelper.hideDialog();
        }
        update();

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
