import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:kamelion/app/components/home_app_bar.dart';

import '../controllers/home_search_controller.dart';

class HomeSearchView extends GetView<HomeSearchController> {
  const HomeSearchView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeSearchView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // HomeAppBar(userName: "c", coincount: "23"),
          const Center(
            child: Text(
              'HomeSearchView is working',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
