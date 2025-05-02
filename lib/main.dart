// import 'app/modules/home/bindings/home_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kamelion/app/modules/splash/bindings/splash_binding.dart';
import 'package:kamelion/app/services/colors.dart';
import 'package:kamelion/generated/locales.g.dart';
import 'app/routes/app_pages.dart';
import 'app/services/storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await FluttermojiInitializer().initialize();
  await initGetServices();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  return runApp(
    GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetMaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(backgroundColor: Colors.white),
        ),
        defaultTransition: Transition.fade,
        smartManagement: SmartManagement.full,
        debugShowCheckedModeBanner: false,
        locale: const Locale('en', 'US'),
        translationsKeys: AppTranslation.translations,
        initialRoute: AppPages.INITIAL,
        initialBinding: SplashBinding(),
        getPages: AppPages.routes,
      ),
    ),
  );
}

Future<void> initGetServices() async {
  await Get.putAsync<GetStorageService>(() => GetStorageService().initState());
}
