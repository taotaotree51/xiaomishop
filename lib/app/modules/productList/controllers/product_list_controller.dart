import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:xiaomishop/app/models/plist_model.dart';
import 'package:xiaomishop/app/services/httpsClient.dart';

class ProductListController extends GetxController {
  // ============ 数据相关 ============
  /// 商品列表
  RxList<ProductItemModel> productList = <ProductItemModel>[].obs;
  
  /// 当前页码
  RxInt page = 1.obs;
  
  /// 每页数据量
  RxInt pageSize = 10.obs;
  
  /// 是否正在加载
  RxBool isLoading = false.obs;
  
  /// 是否还有更多数据
  RxBool hasMore = true.obs;
  
  /// 分类 ID（从路由参数获取）
  String? cid;
  
  // ============ 滚动控制器 ============
  late ScrollController scrollController;
  
  @override
  void onInit() {
    super.onInit();
    
    // 从路由参数获取 cid
    if (Get.arguments != null && Get.arguments['cid'] != null) {
      cid = Get.arguments['cid'];
    }
    
    // 初始化滚动控制器
    scrollController = ScrollController();
    
    // 添加滚动监听
    scrollController.addListener(_onScroll);
    
    // 加载第一页数据
    getProductList();
  }
  
  @override
  void onClose() {
    // 释放滚动控制器
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.onClose();
  }
  
  /// 滚动监听
  void _onScroll() {
    // 如果滚动到底部，并且不在加载中，且还有更多数据
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
      if (!isLoading.value && hasMore.value) {
        loadMoreData();
      }
    }
  }
  
  /// 获取商品列表（首次加载或刷新）
  Future<void> getProductList() async {
    if (isLoading.value) return;
    
    isLoading.value = true;
    page.value = 1; // 重置为第一页
    hasMore.value = true;
    
    try {
      var response = await HttpsClient.get(
        "/api/plist",
        params: {
          "cid": cid ?? '',
          "page": page.value,
          "pageSize": pageSize.value,
        },
      );
      
      var plistModel = PlistModel.fromJson(response.data);
      
      if (plistModel.result != null && plistModel.result!.isNotEmpty) {
        productList.value = plistModel.result!;
        
        // 判断是否还有更多数据
        if (plistModel.result!.length < pageSize.value) {
          hasMore.value = false;
        }
        
        print('商品列表加载成功：${plistModel.result!.length} 条');
      } else {
        productList.value = [];
        hasMore.value = false;
        print('暂无商品数据');
      }
    } catch (e) {
      print('获取商品列表失败：$e');
      Get.snackbar('错误', '加载商品列表失败');
    } finally {
      isLoading.value = false;
    }
  }
  
  /// 加载更多数据
  Future<void> loadMoreData() async {
    if (isLoading.value || !hasMore.value) return;
    
    isLoading.value = true;
    page.value++; // 页码加1
    
    try {
      var response = await HttpsClient.get(
        "/api/plist",
        params: {
          "cid": cid ?? '',
          "page": page.value,
          "pageSize": pageSize.value,
        },
      );
      
      var plistModel = PlistModel.fromJson(response.data);
      
      if (plistModel.result != null && plistModel.result!.isNotEmpty) {
        // 追加数据到列表
        productList.addAll(plistModel.result!);
        
        // 判断是否还有更多数据
        if (plistModel.result!.length < pageSize.value) {
          hasMore.value = false;
          print('已加载全部商品');
        }
        
        print('加载更多成功：第 ${page.value} 页，${plistModel.result!.length} 条数据');
      } else {
        hasMore.value = false;
        print('没有更多商品了');
      }
    } catch (e) {
      print('加载更多失败：$e');
      page.value--; // 失败时回退页码
      Get.snackbar('错误', '加载更多失败');
    } finally {
      isLoading.value = false;
    }
  }
  
  /// 下拉刷新
  Future<void> onRefresh() async {
    await getProductList();
  }
}
