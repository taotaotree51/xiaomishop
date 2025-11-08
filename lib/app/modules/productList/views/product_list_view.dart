import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/product_list_controller.dart';

class ProductListView extends GetView<ProductListController> {
  const ProductListView({super.key});
  @override
  Widget build(BuildContext context) {
    print(Get.arguments);
    return Scaffold(
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
      body:
      ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            height: 400.h,
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(60.w),
                  width: 400.w,
                  height: 400.h,
                  child: Image.network(
                    "https://img2.baidu.com/it/u=3071988570,4076414112&fm=253&fmt=auto&app=138&f=JPEG?w=400&h=527",
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(padding:  EdgeInsets.all(10.w),
                      child: Text("商品标题",style: TextStyle(fontSize: 42.sp,fontWeight: FontWeight.bold),),
                      ),
                      Padding(padding: EdgeInsets.all(10.w),
                      child: Text("商品副标题",style: TextStyle(fontSize: 36.sp,color: Colors.black54),),
                      ),
                      Padding(padding:  EdgeInsets.all(10.w),
                      child: Text("商品价格",style: TextStyle(fontSize: 42.sp,color: Colors.red),),
                      ),

                    ],
                  )
                )

              ]
            ),
          );
          
        },
      )
    );
  }
}
