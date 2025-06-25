import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
import 'package:kamelion/app/services/snackbar.dart';

class GetSchoolController extends GetxController {
  //TODO: Implement GetSchoolController

  final count = 0.obs;
  RxBool isSchoolSubmited = false.obs;
  RxBool isNameValid = false.obs;
  String? email, name;
  TextEditingController schoolNameController = TextEditingController();
  @override
  void onInit() {
    name = Get.arguments["name"];
    email = Get.arguments["email"];
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

  checkFormValidity() {
    String name = schoolNameController.text.trim();
    isNameValid.value = name.isNotEmpty;
    update();
  }

  submitForm() async {
    if (schoolNameController.text != "") {
      try {
        var response = await APIManager.saveUser(
          email: email ?? "",
          name: name ?? "",
          school: schoolNameController.text,
        );

        if (response.statusCode == 201) {
          isSchoolSubmited.value = true;
        } else {
          debugPrint(
            "An error occurred while getting vendor profile: ${response.data['message']}",
          );
        }
        update();
        return;
      } catch (e) {
        debugPrint("An exception occurred while getting vendor details! $e");
        showMySnackbar(title: "Error", msg: e.toString());
        return;
      }
    }
  }
}
