import 'package:get/get.dart';

class CategoryController extends GetxController {
  //TODO: Implement CategoryController

  RxInt selectIndex = 0.obs; // 选中的索引


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
/**
 * 改变选中的索引
 * @param index 索引
 */
  void changeSelectIndex(int index) {
    selectIndex.value = index;
    update();
  }
}
