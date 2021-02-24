import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:my_app/services_locator.dart';
import 'package:my_app/services/configuration.dart';

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
  final _config = servicesLocator<ConfigurationService>();

  @override
  Widget build(BuildContext context) {
    return LiquidLinearProgressIndicator(
      value: _tween.evaluate(animation),
      valueColor: AlwaysStoppedAnimation(_config.appColor["progressBar"]),
      backgroundColor: _config.appColor["progressBarBackground"],
      borderColor: _config.appColor["progressBarBorder"],
      borderWidth: 0,
      borderRadius: 0,
      center: Text('${(_tween.evaluate(animation) * 100).ceil().toString()}%',
          style: TextStyle(color: _config.appColor["text"], fontSize: 16)),
    );
  }

  @override
  void forEachTween(TweenVisitor visitor) {
    _tween = visitor(_tween, (widget.percent), (value) => Tween(begin: value));
  }
}
