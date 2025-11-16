/// 商品列表 API 响应模型
/// API: https://miapp.itying.com/api/plist?is_bast=1
class PlistModel {
  /// 商品列表
  List<ProductItemModel>? result;

  PlistModel({this.result});

  /// 从 JSON 创建 PlistModel
  PlistModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <ProductItemModel>[];
      json['result'].forEach((v) {
        result!.add(ProductItemModel.fromJson(v));
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

/// 单个商品项模型
class ProductItemModel {
  /// 商品 ID
  String? sId;
  
  /// 商品标题
  String? title;
  
  /// 分类 ID
  String? cid;
  
  /// 价格
  num? price;
  
  /// 商品图片路径
  String? pic;
  
  /// 副标题/描述
  String? subTitle;
  
  /// 小图片路径
  String? sPic;
  
  /// 销量
  int? salecount;
  
  /// 是否热门（1-是 0-否）
  int? isHot;
  
  /// 是否精华/推荐（1-是 0-否）
  int? isBest;
  
  /// 库存
  int? stock;
  
  /// 状态（1-上架 0-下架）
  int? status;
  
  /// 商品描述
  String? content;
  
  /// 分类名称
  String? catTitle;
  
  /// 原价（划线价）
  num? oldPrice;
  
  /// 关键词
  String? keywords;

  ProductItemModel({
    this.sId,
    this.title,
    this.cid,
    this.price,
    this.pic,
    this.subTitle,
    this.sPic,
    this.salecount,
    this.isHot,
    this.isBest,
    this.stock,
    this.status,
    this.content,
    this.catTitle,
    this.oldPrice,
    this.keywords,
  });

  /// 从 JSON 创建 ProductItemModel
  ProductItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    cid = json['cid'];
    price = json['price'];
    pic = json['pic'];
    subTitle = json['sub_title'];
    sPic = json['s_pic'];
    
    // 新增字段（可选）
    salecount = json['salecount'];
    isHot = json['is_hot'];
    isBest = json['is_best'];
    stock = json['stock'];
    status = json['status'];
    content = json['content'];
    catTitle = json['cat_title'];
    oldPrice = json['old_price'];
    keywords = json['keywords'];
  }

  /// 转换为 JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['cid'] = cid;
    data['price'] = price;
    data['pic'] = pic;
    data['sub_title'] = subTitle;
    data['s_pic'] = sPic;
    
    // 新增字段（可选）
    if (salecount != null) data['salecount'] = salecount;
    if (isHot != null) data['is_hot'] = isHot;
    if (isBest != null) data['is_best'] = isBest;
    if (stock != null) data['stock'] = stock;
    if (status != null) data['status'] = status;
    if (content != null) data['content'] = content;
    if (catTitle != null) data['cat_title'] = catTitle;
    if (oldPrice != null) data['old_price'] = oldPrice;
    if (keywords != null) data['keywords'] = keywords;
    
    return data;
  }
  
  // ============ 便捷 Getter 方法 ============
  
  /// 是否为热门商品
  bool get isHotProduct => isHot == 1;
  
  /// 是否为精华/推荐商品
  bool get isBestProduct => isBest == 1;
  
  /// 是否有库存
  bool get hasStock => (stock ?? 0) > 0;
  
  /// 是否上架
  bool get isOnSale => status == 1;
}


