import 'package:flutter/material.dart';

/// KeepAliveWrapper - 页面状态保持组件
/// 
/// 【用途说明】
/// 在 TabBar、PageView 等场景中，切换页面时默认会销毁未显示的页面，
/// 导致页面状态丢失（例如：滚动位置、输入内容、网络请求结果等）。
/// 使用此组件可以保持页面状态，避免重复加载和重建。
/// 
/// 【使用场景】
/// 1. 底部导航栏切换（TabBar）- 保持各个Tab页的状态
/// 2. 左右滑动切换页面（PageView）- 保持滑动历史
/// 3. 列表页面 - 保持滚动位置
/// 4. 表单页面 - 保持用户输入内容
/// 
/// 【使用示例】
/// ```dart
/// TabBarView(
///   children: [
///     KeepAliveWrapper(child: HomePage()),
///     KeepAliveWrapper(child: CategoryPage()),
///     KeepAliveWrapper(child: CartPage()),
///   ],
/// )
/// ```
class KeepAliveWrapper extends StatefulWidget {
  const KeepAliveWrapper(
      {super.key, @required this.child, this.keepAlive = true});

  /// 需要保持状态的子组件
  final Widget? child;
  
  /// 是否保持页面状态
  /// true: 保持状态（默认）
  /// false: 不保持状态，页面切换时会被销毁
  final bool keepAlive;

  @override
  State<KeepAliveWrapper> createState() => _KeepAliveWrapperState();
}

/// KeepAliveWrapper 的状态类
/// 通过混入 AutomaticKeepAliveClientMixin 实现状态保持功能
class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  
  @override
  Widget build(BuildContext context) {
    // 必须调用 super.build(context)，这是 AutomaticKeepAliveClientMixin 的要求
    super.build(context);
    // 返回子组件
    return widget.child!;
  }

  /// 重写 wantKeepAlive 属性
  /// 返回 true 时，页面状态会被保持
  /// 返回 false 时，页面切换时会被销毁
  @override
  bool get wantKeepAlive => widget.keepAlive;  
}
