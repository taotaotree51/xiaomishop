import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xiaomishop/app/services/keepAliveWrapper.dart';
import 'package:xiaomishop/app/services/ityingFonts.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:xiaomishop/app/services/httpsClient.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: Scaffold(body: Stack(children: [_homebody(), _appbar()])),
    );
  }

  Widget _pubuliu() {
    return Container(
      padding: EdgeInsets.all(20.w),
      color: Colors.white,
      child: Obx(
        () => controller.productList.isEmpty
            ? Center(
                child: Padding(
                  padding: EdgeInsets.all(50.h),
                  child: CircularProgressIndicator(),
                ),
              )
            : MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20.w,
                crossAxisSpacing: 10.h,
                itemCount: controller.productList.length,
                // shrinkWrap: true - 让瀑布流根据内容自动计算高度，不占据无限空间
                // 在 ListView 中嵌套可滚动组件时必须设置，否则会报错
                shrinkWrap: true,
                // physics: 禁用自身滚动，交给外层 ListView 统一处理滚动
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  // 获取当前商品数据
                  var product = controller.productList[index];
                  
                  return Container(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 商品图片
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10.r),
                          ),
                          child: Image.network(
                            HttpsClient.getNetPictureUrl(product.pic ?? ''),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 300.h,
                                color: Colors.grey[300],
                                child: Icon(Icons.image, size: 100.w),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10.h),
                        // 商品标题
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Text(
                            product.title ?? '',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 38.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        // 商品副标题/描述
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Text(
                            product.subTitle ?? '',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 32.sp,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        // 商品价格
                        Container(
                          padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 15.h),
                          child: Text(
                            "￥ ${product.price}",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 42.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  Widget _swipe() {
    return SizedBox(
      width: 1080.w,
      height: 682.h,
      child: Obx(
        () => controller.swiperList.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Swiper(
                itemBuilder: (context, index) {
                  var item = controller.swiperList[index];
                  return Image.network(
                    HttpsClient.getNetPictureUrl(item.pic ?? ''),
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: Center(
                          child: Text(
                            item.title ?? '加载失败',
                            style: TextStyle(fontSize: 40.sp),
                          ),
                        ),
                      );
                    },
                  );
                },
                itemCount: controller.swiperList.length,
                pagination: SwiperPagination(),
                autoplay: true,
              ),
      ),
    );
  }

  Widget _homebody() {
    return Positioned(
      top: -58,
      left: 0,
      right: 0,
      bottom: 0,
      child: ListView(
        controller: controller.scrollController,
        children: [
          _swipe(),
          _banner(),
          _fastshot(),
          _gp01(),
          _rexiao(),
          _pubuliu(),
        ],
      ),
    );
  }

  Widget _gp01() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10.h, 30.h, 10.h, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          image: DecorationImage(
            image: NetworkImage("http://www.fzjiading.com/images/00.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        height: 472.h,
      ),
    );
  }

  ///热销甄选
  Widget _rexiao() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 30.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "热销甄选",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 46.sp),
              ),
              Text(
                "更多手机推荐",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38.sp),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 30.h),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 472.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text("左侧"),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Container(
                  height: 472.h,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.green,
                          child: Row(
                            children: [
                              Expanded(flex: 3, child: Text("右1左")),
                              Expanded(flex: 2, child: Text("右1右")),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.red,
                          child: Row(
                            children: [
                              Expanded(flex: 3, child: Text("右2左")),
                              Expanded(flex: 2, child: Text("右2右")),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.green,
                          child: Row(
                            children: [
                              Expanded(flex: 3, child: Text("右3左")),
                              Expanded(flex: 2, child: Text("右3右")),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _fastshot() {
    return Container(
      width: 1080.w,
      height: 472.h,
      color: Colors.black12,
      child: Swiper(
        itemCount: 2,
        itemBuilder: (context, index) {
          return Text("111");
        },
        pagination: SwiperPagination(builder: SwiperPagination.rect),
      ),
    );
  }

  Widget _banner() {
    return SizedBox(
      width: 1080.w,
      height: 92.h,
      child: Image.asset("assets/images/xiaomiBanner.png", fit: BoxFit.cover),
    );
  }

  /// 顶部appbar
  Widget _appbar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Obx(
        () => AppBar(
          title: Container(
            width: 620.w,
            height: 97.h,
            decoration: BoxDecoration(
              backgroundBlendMode: BlendMode.color,
              color: Colors.red,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(34.h, 0, 4, 0),
                  child: Icon(Icons.search),
                ),

                Text(
                  "搜索",
                  style: TextStyle(color: Colors.black26, fontSize: 40.sp),
                ),
              ],
            ),
          ),
          centerTitle: true,
          backgroundColor: controller.flag.value
              ? Colors.red
              : Colors.transparent,
          elevation: 0,
          leading: IconButton(onPressed: () {}, icon: Icon(ItyingFonts.xiaomi)),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.code)),
            IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
          ],
        ),
      ),
    );
  }
}
