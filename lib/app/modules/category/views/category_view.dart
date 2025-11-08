import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/category_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xiaomishop/app/services/httpsClient.dart';

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
          _leftCategoryList(),
          _rightSubCategoryGrid(),
        ],
      ),
    );
  }

  /// 左侧一级分类列表
  Widget _leftCategoryList() {
    return Container(
      width: 280.w,
      height: double.infinity,
      child: Obx(
        () => controller.categoryList.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: controller.categoryList.length,
                itemBuilder: (context, index) {
                  var category = controller.categoryList[index];
                  return Container(
                    width: double.infinity,
                    height: 140.h,
                    child: Obx(
                      () => InkWell(
                        onTap: () {
                          controller.changeSelectIndex(index);
                        },
                        child: Stack(
                          children: [
                            // 左侧选中指示条
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
                            // 分类名称
                            Center(
                              child: Text(
                                category.title ?? '',
                                style: TextStyle(
                                  fontSize: 38.sp,
                                  color: controller.selectIndex.value == index
                                      ? Colors.red
                                      : Colors.black,
                                  fontWeight: controller.selectIndex.value == index
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  /// 右侧二级分类网格
  Widget _rightSubCategoryGrid() {
    return Expanded(
      child: Container(
        height: double.infinity,
        color: Colors.white,
        child: Obx(
          () => controller.subCategoryList.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 20.h),
                      Text(
                        '加载中...',
                        style: TextStyle(fontSize: 32.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : GridView.builder(
                  padding: EdgeInsets.all(20.w),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 20.w, //左右间距
                    childAspectRatio: 0.8, //宽高比
                    mainAxisSpacing: 20.h, //上下间距
                  ),
                  itemCount: controller.subCategoryList.length,
                  itemBuilder: (context, index) {
                    var subCategory = controller.subCategoryList[index];
                    return InkWell(
                      onTap: () {
                        print('点击了：${subCategory.title}');
                        Get.toNamed("/product-list",arguments: {"cid":controller.subCategoryList[index].sId});



                      },
                      child: Column(
                        children: [
                          // 二级分类图片
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: Image.network(
                                  HttpsClient.getNetPictureUrl(subCategory.pic ?? ''),
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.grey[300],
                                      child: Icon(
                                        Icons.image,
                                        size: 80.w,
                                        color: Colors.grey,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          // 二级分类名称
                          Text(
                            subCategory.title ?? '',
                            style: TextStyle(
                              fontSize: 32.sp,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
