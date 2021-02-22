import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:flutter/material.dart';

/// TODO: リファクタリング
class LiquidLinearProgressIndicatorWithText extends ImplicitlyAnimatedWidget {
  final double percent;
  LiquidLinearProgressIndicatorWithText({
    Key key,
    @required this.percent,
    Duration duration = const Duration(milliseconds: 300),
    Curve curve = Curves.linear,
  }) : super(duration: duration, curve: curve, key: key);

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _LiquidLinearProgressIndicatorWithTextState();
}

class _LiquidLinearProgressIndicatorWithTextState
    extends AnimatedWidgetBaseState<LiquidLinearProgressIndicatorWithText> {
  Tween _tween;

  @override
  Widget build(BuildContext context) {
    return LiquidLinearProgressIndicator(
      value: _tween.evaluate(animation),
      valueColor:
          AlwaysStoppedAnimation(Theme.of(context).primaryColor.withAlpha(150)),
      backgroundColor: Colors.white,
      borderColor: Theme.of(context).primaryColor,
      borderWidth: 0,
      borderRadius: 0,
      center: Text('${(_tween.evaluate(animation) * 100).ceil().toString()}%',
          style: TextStyle(color: Colors.black, fontSize: 16)),
    );
  }

  @override
  void forEachTween(TweenVisitor visitor) {
    _tween = visitor(_tween, (widget.percent), (value) => Tween(begin: value));
  }
}
