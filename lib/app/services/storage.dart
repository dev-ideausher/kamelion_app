import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'enigma.dart';

class GetStorageService extends GetxService {
  static final _runData = GetStorage('runData');

  Future<GetStorageService> initState() async {
    await GetStorage.init('runData');
    return this;
  }

  // we are utilisig encrypt class we decrypt once we read and encrypt before write.

  String get encjwToken => decryptAESCryptoJS(_runData.read('jwToken')) ?? '';

  set encjwToken(String val) =>
      _runData.write('jwToken', encryptAESCryptoJS(val));

  bool get isLoggedIn => _runData.read('isLoggedIn') ?? false;

  set isLoggedIn(bool val) => _runData.write('isLoggedIn', (val));

  void logout() {
    _runData.remove("jwToken");
  }
}
