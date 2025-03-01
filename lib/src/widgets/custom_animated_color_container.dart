import 'package:flutter/material.dart';

class CustomAnimatedColorContainer extends StatefulWidget {
  const CustomAnimatedColorContainer({
    super.key,
    required this.color,
    required this.child,
    required this.duration,
    this.borderRadius,
    this.curve,
  });

  final Duration duration;
  final Color color;
  final BorderRadius? borderRadius;
  final Widget child;
  final Curve? curve;

  @override
  State<CustomAnimatedColorContainer> createState() => _CustomAnimatedColorContainerState();
}

class _CustomAnimatedColorContainerState extends State<CustomAnimatedColorContainer> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Color? _oldColor;
  Color? _currentColor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve ?? Curves.easeInOut);
    _currentColor = widget.color;
    _oldColor = widget.color;
  }

  @override
  void didUpdateWidget(CustomAnimatedColorContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (oldWidget.color != widget.color) {
      _oldColor = oldWidget.color;
      _currentColor = widget.color;
      _controller
        ..reset()
        ..forward();

      _animation = CurvedAnimation(
        parent: _controller,
        curve: widget.curve ?? Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            // Background with previous color
            Container(
              decoration: BoxDecoration(
                color: _oldColor,
                borderRadius: widget.borderRadius,
              ),
            ),
            
            // New color with circular reveal
            ClipPath(
              clipper: _CircleRevealClipper(
                progress: _animation.value,
                center: Alignment.center,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: _currentColor,
                  borderRadius: widget.borderRadius,
                ),
              ),
            ),
            
            // Content
            widget.child,
          ],
        );
      },
    );
  }
}

class _CircleRevealClipper extends CustomClipper<Path> {
  final Alignment center;
  final double progress;

  _CircleRevealClipper({required this.progress, required this.center});

  @override
  Path getClip(Size size) {
    final centerOffset = center.alongOffset(Offset(size.width, size.height));
    final radius = progress * (size.width + size.height);
    return Path()
      ..addOval(Rect.fromCircle(center: centerOffset, radius: radius));
  }

  @override
  bool shouldReclip(_CircleRevealClipper oldClipper) {
    return oldClipper.progress != progress;
  }
}