import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:xiaomishop/app/modules/home/views/home_view.dart';
import 'package:xiaomishop/app/modules/category/views/category_view.dart';
import 'package:xiaomishop/app/modules/give/views/give_view.dart';
import 'package:xiaomishop/app/modules/cart/views/cart_view.dart';
import 'package:xiaomishop/app/modules/user/views/user_view.dart';



class TabsController extends GetxController {
  //TODO: Implement TabsController
  RxInt currentIndex = 0.obs;
  PageController pageController = PageController(initialPage: 0);
  List<Widget> pages = [
    HomeView(),
    CategoryView(),
    GiveView(),
    CartView(),
    UserView(),
  ];

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

  void setCurrentIndex(int index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
    update();
  }
}
