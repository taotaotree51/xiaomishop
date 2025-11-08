import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:xiaomishop/app/models/focus_model.dart';
import 'package:xiaomishop/app/models/plist_model.dart';
import 'package:xiaomishop/app/services/httpsClient.dart';

class HomeController extends GetxController {
  
  /// 标志位：判断页面是否滚动超过 10 像素
  /// 用于控制 AppBar 背景色的显示/隐藏
  RxBool flag = false.obs;

  /// 滚动控制器
  ScrollController scrollController = ScrollController();

  /// 轮播图数据列表（响应式）
  RxList<FocusItemModel> swiperList = <FocusItemModel>[].obs;

  /// 商品列表数据（响应式）
  RxList<ProductItemModel> productList = <ProductItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    // 获取轮播图数据
    getFocusData();
    
    // 获取商品列表数据
    getProductList();

    // 监听滚动事件
    scrollController.addListener(() {
      if (scrollController.position.pixels > 10) {
        if (!flag.value) {
          flag.value = true;
        }
      } else {
        if (flag.value) {
          flag.value = false;
        }
      }
    });
  }

  @override
  void onClose() {
    scrollController.dispose();  // 释放资源，防止内存泄漏
    super.onClose();
  }

  /// 获取轮播图数据
  /// API: https://miapp.itying.com/api/focus
  Future<void> getFocusData() async {
    try {
      var response = await HttpsClient.get("/api/focus");
      
      // 使用 FocusModel 解析数据
      var focusModel = FocusModel.fromJson(response.data);
      
      if (focusModel.result != null) {
        swiperList.value = focusModel.result!;
      }
      
      print('轮播图数据加载成功：${swiperList.length} 条');
    } catch (e) {
      print('获取轮播图数据失败：$e');
    }
  }

  /// 获取商品列表数据
  /// API: https://miapp.itying.com/api/plist?is_bast=1
  Future<void> getProductList() async {
    try {
      var response = await HttpsClient.get("/api/plist", params: {"is_bast": "1"});
      
      // 使用 PlistModel 解析数据
      var plistModel = PlistModel.fromJson(response.data);
      
      if (plistModel.result != null) {
        productList.value = plistModel.result!;
      }
      
      print('商品列表加载成功：${productList.length} 条');
    } catch (e) {
      print('获取商品列表失败：$e');
    }
  }
}
