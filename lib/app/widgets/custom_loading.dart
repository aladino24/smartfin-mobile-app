import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomLoading extends StatefulWidget {
  final double size;
  final String? text;
  final Color? color;
  final bool useContainer;

  const CustomLoading({
    super.key,
    this.size = 90,
    this.text,
    this.color,
    this.useContainer = false,
  });

  @override
  State<CustomLoading> createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RotationTransition(
          turns: _controller,
          child: SvgPicture.asset(
            'assets/svg/loading.svg',
            width: widget.size,
            height: widget.size,
            colorFilter: widget.color != null
                ? ColorFilter.mode(
                    widget.color!,
                    BlendMode.srcIn,
                  )
                : null,
          ),
        ),

        if (widget.text != null) ...[
          const SizedBox(height: 18),

          Text(
            widget.text!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: widget.color ?? Colors.white,
            ),
          ),
        ],
      ],
    );

    if (widget.useContainer) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.75),
            borderRadius: BorderRadius.circular(24),
          ),
          child: content,
        ),
      );
    }

    return Center(child: content);
  }
}