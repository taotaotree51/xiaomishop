/// Focus API 响应模型
/// API: https://miapp.itying.com/api/focus
class FocusModel {
  /// 轮播图列表
  List<FocusItemModel>? result;

  FocusModel({this.result});

  /// 从 JSON 创建 FocusModel
  FocusModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <FocusItemModel>[];
      json['result'].forEach((v) {
        result!.add(FocusItemModel.fromJson(v));
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

/// 单个轮播图项模型
class FocusItemModel {
  /// 轮播图 ID
  String? sId;
  
  /// 标题
  String? title;
  
  /// 状态（1: 启用）
  String? status;
  
  /// 图片路径
  String? pic;
  
  /// 跳转链接
  String? url;
  
  /// 位置/排序
  int? position;

  FocusItemModel({
    this.sId,
    this.title,
    this.status,
    this.pic,
    this.url,
    this.position,
  });

  /// 从 JSON 创建 FocusItemModel
  FocusItemModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    status = json['status'];
    pic = json['pic'];
    url = json['url'];
    position = json['position'];
  }

  /// 转换为 JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['status'] = status;
    data['pic'] = pic;
    data['url'] = url;
    data['position'] = position;
    return data;
  }
}

