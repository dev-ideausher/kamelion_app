import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/quize_collect_coin_controller.dart';

class QuizeCollectCoinView extends GetView<QuizeCollectCoinController> {
  const QuizeCollectCoinView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuizeCollectCoinView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'QuizeCollectCoinView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
