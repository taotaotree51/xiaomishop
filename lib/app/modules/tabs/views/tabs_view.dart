import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tabs_controller.dart';

class TabsView extends GetView<TabsController> {
  const TabsView({super.key});


  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Scaffold(
      // appBar: AppBar(
      //   title: const Text('TabsView'),
      //   centerTitle: true,
      // ),
      body:PageView(
        controller: controller.pageController,
        children: controller.pages,
        onPageChanged: (index) {
          controller.setCurrentIndex(index);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.red,
        iconSize: 35,
        currentIndex: controller.currentIndex.value ,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          controller.setCurrentIndex(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gite),
            label: 'Give',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cast),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
      ),
    ));
    
  }
}
