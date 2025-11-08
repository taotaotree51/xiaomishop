import 'package:get/get.dart';
import 'package:xiaomishop/app/models/pcate_model.dart';
import 'package:xiaomishop/app/services/httpsClient.dart';

class CategoryController extends GetxController {
  
  /// 选中的分类索引
  RxInt selectIndex = 0.obs;
  
  /// 一级分类列表（响应式）
  RxList<CategoryItemModel> categoryList = <CategoryItemModel>[].obs;

  /// 二级分类列表（响应式）
  RxList<CategoryItemModel> subCategoryList = <CategoryItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    
    // 获取一级分类数据
    getCategoryList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  /// 改变选中的索引
  /// @param index 索引
  void changeSelectIndex(int index) {
    selectIndex.value = index;
    
    // 切换分类时，获取对应的二级分类
    if (categoryList.isNotEmpty && index < categoryList.length) {
      var selectedCategory = categoryList[index];
      if (selectedCategory.sId != null) {
        getSubCategoryList(selectedCategory.sId!);
      }
    }
  }

  /// 获取一级分类列表
  /// API: https://miapp.itying.com/api/pcate
  Future<void> getCategoryList() async {
    try {
      var response = await HttpsClient.get("/api/pcate");
      
      // 使用 PcateModel 解析数据
      var pcateModel = PcateModel.fromJson(response.data);
      
      if (pcateModel.result != null) {
        // 只获取一级分类（pid == "0"）且状态启用的分类
        categoryList.value = pcateModel.result!
            .where((item) => item.isFirstLevel && item.isActive)
            .toList();
        
        print('一级分类加载成功：${categoryList.length} 条');
        
        // 自动获取第一个分类的二级分类
        if (categoryList.isNotEmpty && categoryList[0].sId != null) {
          getSubCategoryList(categoryList[0].sId!);
        }
      }
    } catch (e) {
      print('获取一级分类失败：$e');
    }
  }

  /// 获取二级分类列表
  /// API: https://miapp.itying.com/api/pcate?pid={一级分类ID}
  /// @param pid 父级分类ID（一级分类的ID）
  Future<void> getSubCategoryList(String pid) async {
    try {
      var response = await HttpsClient.get("/api/pcate", params: {"pid": pid});
      
      // 使用 PcateModel 解析数据（同一个 Model 可以用于二级分类）
      var pcateModel = PcateModel.fromJson(response.data);
      
      if (pcateModel.result != null) {
        // 获取启用状态的二级分类
        subCategoryList.value = pcateModel.result!
            .where((item) => item.isActive)
            .toList();
        
        print('二级分类加载成功：${subCategoryList.length} 条');
        
        // 调试：打印第一个分类的图片信息
        if (subCategoryList.isNotEmpty) {
          var firstItem = subCategoryList[0];
          print('第一个分类标题：${firstItem.title}');
          print('第一个分类图片路径：${firstItem.pic}');
          print('完整图片URL：${HttpsClient.getNetPictureUrl(firstItem.pic ?? '')}');
        }
      } else {
        subCategoryList.value = [];
        print('该分类下没有二级分类');
      }
    } catch (e) {
      print('获取二级分类失败：$e');
      subCategoryList.value = [];
    }
  }
}
