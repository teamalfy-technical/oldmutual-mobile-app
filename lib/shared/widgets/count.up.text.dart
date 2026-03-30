import 'package:flutter/material.dart';
import 'package:oldmutual_pensions_app/core/utils/utils.dart';

/// Animated text widget that counts up from 0 to the target amount,
/// displaying the value as formatted currency.
class PCountUpText extends StatefulWidget {
  final double amount;
  final String? symbol;
  final TextStyle? style;
  final TextAlign? textAlign;
  final Duration duration;

  const PCountUpText({
    super.key,
    required this.amount,
    this.symbol,
    this.style,
    this.textAlign,
    this.duration = const Duration(milliseconds: 1200),
  });

  @override
  State<PCountUpText> createState() => _PCountUpTextState();
}

class _PCountUpTextState extends State<PCountUpText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant PCountUpText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.amount != widget.amount) {
      _controller.forward(from: 0);
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
      animation: _animation,
      builder: (context, child) {
        final currentValue = _animation.value * widget.amount;
        return Text(
          PFormatter.formatCurrency(
            amount: currentValue,
            symbol: widget.symbol,
          ),
          textAlign: widget.textAlign,
          softWrap: true,
          style: widget.style,
        );
      },
    );
  }
}
