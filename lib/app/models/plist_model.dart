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

  ProductItemModel({
    this.sId,
    this.title,
    this.cid,
    this.price,
    this.pic,
    this.subTitle,
    this.sPic,
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
    return data;
  }
}


