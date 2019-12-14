import 'package:flutter/material.dart';
class SABT extends StatefulWidget {
  final Widget child;
  const SABT({
    Key key,
    @required this.child,
  }) : super(key: key);
  @override
  _SABTState createState() {
    return new _SABTState();
  }
}
class _SABTState extends State<SABT> with TickerProviderStateMixin {
  ScrollPosition _position;
  bool _visible;
  double _scale = 1;
  AnimationController controller;
  bool _isMovingDown = false;
  double offsetX = -38;
  double offsetY = 0;
  Offset showOffset = Offset(-0.08, 0);
  Offset offsetMoveDown = Offset(-38, 0);
  double prevHeight = 124;

  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeListener();
    _addListener();
  }

  void _addListener() {
    _position = Scrollable
        .of(context)
        ?.position;
    _position?.addListener(_positionListener);
    _positionListener();
  }

  void _removeListener() {
    _position?.removeListener(_positionListener);
  }

  void _positionListener() {
    final FlexibleSpaceBarSettings settings =
    context.inheritFromWidgetOfExactType(FlexibleSpaceBarSettings);

/*    bool visible = settings == null ||
        settings.currentExtent <= settings.minExtent;*/
    setState(() {
      if (settings.currentExtent <= settings.minExtent && !_isMovingDown) {
        _isMovingDown = true;
        offsetX = -0.08;
      }
      else if (settings.currentExtent == settings.maxExtent && _isMovingDown) {
        _isMovingDown = false;
        offsetX = -38;
        offsetY = 0;
      }
      //prevHeight > cur: moving up, prevHeight < cur: movingDown
      if (prevHeight > settings.currentExtent) {
        _isMovingDown = false;
      }
      else if (prevHeight < settings.currentExtent) {
        _isMovingDown = true;
      }
      prevHeight = settings.currentExtent;

      if (_isMovingDown && offsetX >= -38 &&
          settings.currentExtent > settings.minExtent) {
        offsetX -= 0.86;
        offsetY += 0.1;
      }
      else if (!_isMovingDown && offsetX <= -0.08 - 0.86 &&
          settings.currentExtent < settings.maxExtent) {
        offsetX += 0.86;
        offsetY -= 0.1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_scale);
    return Visibility(
      child: Container(
        child: Transform.translate(
          /*child: Transform.scale(
                      child: widget.child,
                      scale: _scale < 1 ? 1 : _scale),
                  //offset: Offset(offsetX, _scale),
                  offset: Offset(-_scale, 0),*/
          child: widget.child,
          offset: Offset(offsetX, 0),
        ),
      ),
      visible: true,
    );
  }
}