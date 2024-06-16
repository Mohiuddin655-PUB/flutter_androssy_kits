import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AndrossyRender extends SingleChildRenderObjectWidget {
  final Function(Size size) render;

  const AndrossyRender({
    super.key,
    required this.render,
    super.child,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _Render(render);
  }
}

class _Render extends RenderProxyBox {
  final Function(Size size) render;

  Size? ox;

  _Render(this.render);

  @override
  void performLayout() {
    super.performLayout();
    try {
      Size? nx = child?.size;
      if (nx != null && ox != nx) {
        ox = nx;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          render(nx);
        });
      }
    } catch (_) {}
  }
}
