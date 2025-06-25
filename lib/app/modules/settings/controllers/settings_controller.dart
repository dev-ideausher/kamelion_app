import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/routes/app_pages.dart';
import 'package:kamelion/app/services/auth.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/app/services/dio/api_service.dart';
import 'package:kamelion/app/services/snackbar.dart';

class SettingsController extends GetxController {
  //TODO: Implement SettingsController

  final count = 0.obs;
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

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('Logout'),
            content: Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                onPressed: () {
                  Auth().logOutUser();
                },
                child: Text(
                  'Logout',
                  style: TextStyle(color: context.brandColor1),
                ),
              ),
            ],
          ),
    );
  }

  void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('Delete Account'),
            content: Text('Are you sure you want to delete account?'),
            actions: [
              TextButton(
                onPressed: () async {
                  try {
                    var res = await APIManager.deleteAccount();
                    if (res.statusCode == 200) {
                      Get.offAllNamed(Routes.AUTH_DIRECTION);
                      showMySnackbar(msg: "User deleted");
                    }
                  } on DioException catch (dioError) {
                    showMySnackbar(msg: dioError.message ?? "");
                  } catch (e, s) {
                    showMySnackbar(
                      // title: LocaleKeys.somethingWentWrong.tr,
                      msg: e.toString(),
                    );
                  }
                },
                child: Text(
                  'Delete Account',
                  style: TextStyle(color: context.redBg),
                ),
              ),
            ],
          ),
    );
  }
}
