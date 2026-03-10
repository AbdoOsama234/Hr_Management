import 'package:flutter/material.dart';

class PulsingWidget extends StatefulWidget {
  final Tween<double> tween;
  final Widget child;
  final Duration duration;

  const PulsingWidget({required this.child, required this.duration, required this.tween});
  _PulsingWidget createState() => _PulsingWidget();
}

class _PulsingWidget extends State<PulsingWidget> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Duration _duration;
  late Tween<double> _tween;

  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _tween = widget.tween;
    _duration = widget.duration;
    _animationController = AnimationController(
      vsync: this,
      duration: _duration,
    );
    final CurvedAnimation curve = CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    );
    _animation = _tween.animate(curve);
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}