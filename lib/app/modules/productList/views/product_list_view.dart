import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:xiaomishop/app/services/httpsClient.dart';

import '../controllers/product_list_controller.dart';

class ProductListView extends GetView<ProductListController> {
  const ProductListView({super.key});
  @override
  Widget build(BuildContext context) {
    
    print(Get.arguments);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 246, 246),
      appBar: AppBar(
        title: Container(
          width: 950.w,
          height: 97.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10.h, 0, 4, 0),
                child: Icon(Icons.search, color: Colors.black26),
              ),

              Text(
                "搜索",
                style: TextStyle(color: Colors.black26, fontSize: 40.sp),
              ),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,

        elevation: 0, //去掉阴影
      ),
      body:Stack(
        children: [

          _productList(),
          _subHeader(),
        ],
      )


    );
  }

  Widget _productList() {
    return Obx(() {
      // 如果列表为空且正在加载，显示加载指示器
      if (controller.productList.isEmpty && controller.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      
      // 如果列表为空且未加载，显示空状态
      if (controller.productList.isEmpty && !controller.isLoading.value) {
        return Center(
          child: Text(
            '暂无商品数据',
            style: TextStyle(fontSize: 40.sp, color: Colors.black54),
          ),
        );
      }
      
      // 使用 RefreshIndicator 包裹 ListView 实现下拉刷新
      return RefreshIndicator(
        onRefresh: controller.onRefresh, // 下拉刷新回调
        color: Colors.blue, // 刷新指示器颜色
        backgroundColor: Colors.white, // 背景颜色
        child: ListView.builder(
          controller: controller.scrollController, // 添加滚动控制器
          padding: EdgeInsets.fromLTRB(26.w, 140.h, 26.w, 20.h),
          itemCount: controller.productList.length + 1, // +1 用于底部加载指示器
          itemBuilder: (context, index) {
          // 底部加载指示器
          if (index == controller.productList.length) {
            return _buildLoadMoreIndicator();
          }
          
          // 获取当前商品数据
          var product = controller.productList[index];
          
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.w),
            ),
            height: 400.h,
            margin: EdgeInsets.only(bottom: 20.h),
            child: Row(
              children: [
                // 商品图片
                Container(
                  padding: EdgeInsets.all(60.w),
                  width: 400.w,
                  height: 400.h,
                  child: Image.network(
                    HttpsClient.getNetPictureUrl(product.pic ?? ''),
                    fit: BoxFit.fitHeight,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.broken_image, size: 100.w, color: Colors.grey);
                    },
                  ),
                ),
                // 商品详情
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 商品标题
                        Padding(
                          padding: EdgeInsets.only(top: 20.h, bottom: 10.h),
                          child: Text(
                            product.title ?? '商品标题',
                            style: TextStyle(
                              fontSize: 42.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // 商品副标题
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: Text(
                            product.subTitle ?? '',
                            style: TextStyle(fontSize: 36.sp, color: Colors.black54),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // 商品属性（可选）
                        if (product.salecount != null || product.stock != null)
                          Container(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: Row(
                              children: [
                                if (product.salecount != null)
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "销量",
                                          style: TextStyle(fontSize: 34.sp, color: Colors.black54),
                                        ),
                                        Text(
                                          "${product.salecount}",
                                          style: TextStyle(fontSize: 34.sp, color: Colors.red),
                                        ),
                                      ],
                                    ),
                                  ),
                                if (product.stock != null)
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "库存",
                                          style: TextStyle(fontSize: 34.sp, color: Colors.black54),
                                        ),
                                        Text(
                                          "${product.stock}",
                                          style: TextStyle(
                                            fontSize: 34.sp,
                                            color: product.hasStock ? Colors.green : Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                if (product.isBestProduct)
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          "精选",
                                          style: TextStyle(fontSize: 34.sp, color: Colors.black54),
                                        ),
                                        Icon(Icons.star, size: 34.sp, color: Colors.orange),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        // 商品价格
                        Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: Row(
                            children: [
                              Text(
                                "¥${product.price ?? 0}",
                                style: TextStyle(
                                  fontSize: 46.sp,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (product.oldPrice != null && product.oldPrice! > 0) ...[
                                SizedBox(width: 20.w),
                                Text(
                                  "¥${product.oldPrice}",
                                  style: TextStyle(
                                    fontSize: 32.sp,
                                    color: Colors.black38,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      );
    });
  }
  
  /// 构建底部加载指示器
  Widget _buildLoadMoreIndicator() {
    return Obx(() {
      if (controller.isLoading.value) {
        // 正在加载
        return Container(
          padding: EdgeInsets.symmetric(vertical: 30.h),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 40.w,
                height: 40.w,
                child: CircularProgressIndicator(strokeWidth: 3),
              ),
              SizedBox(width: 20.w),
              Text(
                '加载中...',
                style: TextStyle(fontSize: 32.sp, color: Colors.black54),
              ),
            ],
          ),
        );
      } else if (!controller.hasMore.value) {
        // 没有更多数据
        return Container(
          padding: EdgeInsets.symmetric(vertical: 30.h),
          alignment: Alignment.center,
          child: Text(
            '—— 已加载全部商品 ——',
            style: TextStyle(fontSize: 32.sp, color: Colors.black38),
          ),
        );
      } else {
        // 还有更多但未加载
        return SizedBox(height: 30.h);
      }
    });
  }
  
  Widget _subHeader()
  {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: Container(
        height: 120.h,
        width: 1080.w,
        //color: Colors.white,
        decoration:BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: Colors.black12,
              width: 1.w,
            )
          )
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  print("全部");
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 16.h, 0, 16.h),
                  child: Text(
                    "全部",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 36.sp, color: Colors.black),
                  ),
                ),
              )
            ),
                        Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  print("全部");
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 16.h, 0, 16.h),
                  child: Text(
                    "全部",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 36.sp, color: Colors.black),
                  ),
                ),
              )
            ),
                        Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  print("全部");
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 16.h, 0, 16.h),
                  child: Text(
                    "全部",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 36.sp, color: Colors.black),
                  ),
                ),
              )
            ),
                        Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  print("全部");
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 16.h, 0, 16.h),
                  child: Text(
                    "全部",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 36.sp, color: Colors.black),
                  ),
                ),
              )
            ),

          ],
        ),
      ),
    );
  }
}
