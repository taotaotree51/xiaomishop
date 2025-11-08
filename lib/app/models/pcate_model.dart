/// 商品分类 API 响应模型
/// 
/// API 接口：
/// - 一级分类：https://miapp.itying.com/api/pcate
/// - 二级分类：https://miapp.itying.com/api/pcate?pid={一级分类ID}
/// 
/// 使用说明：
/// 同一个 Model 可以用于一级分类和二级分类，因为数据结构相同
class PcateModel {
  /// 分类列表
  List<CategoryItemModel>? result;

  PcateModel({this.result});

  /// 从 JSON 创建 PcateModel
  PcateModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <CategoryItemModel>[];
      json['result'].forEach((v) {
        result!.add(CategoryItemModel.fromJson(v));
      });
    }
  }

  /// 转换为 JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

/// 单个分类项模型（支持一级和二级分类）
class CategoryItemModel {
  /// 分类 ID
  String? sId;
  
  /// 分类标题
  String? title;
  
  /// 状态（1: 启用，0: 禁用）
  int? status;
  
  /// 分类图片路径
  String? pic;
  
  /// 父级分类 ID（"0" 表示一级分类，其他值表示二级分类）
  String? pid;
  
  /// 排序值
  int? sort;
  
  /// 是否精选（二级分类特有，1: 是，0: 否）
  int? isBest;
  
  /// 是否直接跳转到商品（0: 否，1: 是）
  int? goProduct;
  
  /// 关联的商品 ID
  String? productId;

  CategoryItemModel({
    this.sId,
    this.title,
    this.status,
    this.pic,
    this.pid,
    this.sort,
    this.isBest,
    this.goProduct,
    this.productId,
  });

  /// 从 JSON 创建 CategoryItemModel
  CategoryItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    // 处理 status：可能是 int 或 String
    status = json['status'] is int ? json['status'] : int.tryParse(json['status']?.toString() ?? '0');
    pic = json['pic'];
    pid = json['pid'];
    // 处理 sort：可能是 int 或 String
    sort = json['sort'] is int ? json['sort'] : int.tryParse(json['sort']?.toString() ?? '0');
    // 处理 isBest：可能是 int 或 String
    isBest = json['is_best'] is int ? json['is_best'] : int.tryParse(json['is_best']?.toString() ?? '0');
    // 处理 goProduct：可能是 int 或 String
    goProduct = json['go_product'] is int ? json['go_product'] : int.tryParse(json['go_product']?.toString() ?? '0');
    productId = json['product_id'];
  }

  /// 转换为 JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['status'] = status;
    data['pic'] = pic;
    data['pid'] = pid;
    data['sort'] = sort;
    data['is_best'] = isBest;
    data['go_product'] = goProduct;
    data['product_id'] = productId;
    return data;
  }
  
  /// 是否为一级分类
  bool get isFirstLevel => pid == "0";
  
  /// 是否为二级分类
  bool get isSecondLevel => pid != "0" && pid != null && pid!.isNotEmpty;
  
  /// 是否启用
  bool get isActive => status == 1;
  
  /// 是否为精选分类（二级分类）
  bool get isBestCategory => isBest == 1;
}

