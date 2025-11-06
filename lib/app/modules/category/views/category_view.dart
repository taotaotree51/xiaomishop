import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/category_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: 800.w,
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
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.code)),
          IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
        ],
        elevation: 0, //去掉阴影
      ),
      body: Row(
        children: [
          Container(
            width: 280.w,
            height: double.infinity,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  height: 140.h,
                  child: Obx(
                    ()=>InkWell(
                    onTap: () {
                      controller.changeSelectIndex(index);
                    },
                    child: Stack(                    
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: 10.w,
                          height: 46.h,
                          color: controller.selectIndex.value == index
                              ? Colors.red
                              : Colors.white,
                        ),
                      ),

                      Center(
                        child: Text("第${index + 1}个")
                        ),
                    ],
                  ),
                  )
                  
                  )
                );
              },
            ),
          ),
          Expanded(
            child: Container(height: double.infinity, color: Colors.black12),
          ),
        ],
      ),
    );
  }
}
