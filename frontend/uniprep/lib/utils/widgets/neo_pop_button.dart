import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uniprep/app/theme/app_colors.dart';

class NeoPopLogoButton extends StatefulWidget {
  final VoidCallback? onPressed;

  const NeoPopLogoButton({super.key, this.onPressed});

  @override
  State<NeoPopLogoButton> createState() => _NeoPopLogoButtonState();
}

class _NeoPopLogoButtonState extends State<NeoPopLogoButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pressAnimation;

  static const double _size = 80.0;
  static const double _shadowOffsetX = 5.0;
  static const double _shadowOffsetY = 5.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
      reverseDuration: const Duration(milliseconds: 150),
    );
    _pressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) => _controller.forward();

  void _onTapUp(TapUpDetails _) async {
    HapticFeedback.mediumImpact();
    await _controller.reverse();
    widget.onPressed?.call();
  }

  void _onTapCancel() => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    final shadowColor = AppColors.lightTextMuted;
    final faceColor = AppColors.lightCard;
    final faceBorderColor = AppColors.lightBorder;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _pressAnimation,
        builder: (context, _) {
          final press = _pressAnimation.value;

          // Default: face is at (0,0) — shadow peeks at bottom-right
          // Pressed: face moves TO the shadow offset — covers it
          final faceLeft = press * _shadowOffsetX;
          final faceTop = press * _shadowOffsetY;

          return SizedBox(
            width: _size + _shadowOffsetX,
            height: _size + _shadowOffsetY,
            child: Stack(
              children: [
                // ── SHADOW — fixed bottom-right, always visible by default
                Positioned(
                  left: _shadowOffsetX,
                  top: _shadowOffsetY,
                  child: Container(
                    width: _size,
                    height: _size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: shadowColor,
                    ),
                  ),
                ),

                // ── TOP FACE — starts at (0,0), slides into shadow on press
                Positioned(
                  left: faceLeft,
                  top: faceTop,
                  child: Container(
                    width: _size,
                    height: _size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: faceColor,
                      border: Border.all(
                        color: faceBorderColor,
                        width: 1,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/Placeio.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}