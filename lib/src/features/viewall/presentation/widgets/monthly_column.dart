import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/utils.dart';
import '../../domain/entities/monthly_chart_data.dart';

class MonthlyColumn extends StatefulWidget {
  const MonthlyColumn({
    required this.monthData,
    required this.columnHeightFactor,
    super.key,
  });

  final MonthlyChartDataEntity monthData;
  final double columnHeightFactor;

  @override
  State<MonthlyColumn> createState() => _MonthlyColumnState();
}

class _MonthlyColumnState extends State<MonthlyColumn>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    );
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Tooltip(
          message: '\$${widget.monthData.balance.toStringAsFixed(0)}',
          padding: const EdgeInsets.all(xsSize),
          verticalOffset: constraints.maxHeight / 2,
          preferBelow: false,
          decoration: const ShapeDecoration(
            gradient: buttonsGradientReversed,
            shape: TooltipCustomBorder(widgetPadding: xsSize),
          ),
          showDuration: const Duration(seconds: 3),
          triggerMode: TooltipTriggerMode.tap,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  alignment: Alignment.bottomCenter,
                  width: 8,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(mediumSize),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SizeTransition(
                        sizeFactor: _animation,
                        child: AnimatedContainer(
                          height:
                              constraints.maxHeight * widget.columnHeightFactor,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(smallSize),
                            gradient: buttonsGradient,
                          ),
                          curve: Curves.ease,
                          duration: const Duration(milliseconds: 1300),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                widget.monthData.date.month.toString().padLeft(2, '0'),
                style: const TextStyle(
                  fontSize: smallText,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MonthlyColumnLoading extends StatelessWidget {
  const MonthlyColumnLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Skeleton.leaf(
            child: Container(
              width: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(mediumSize),
                color: Colors.grey[200],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        const Text(
          '01',
          style: TextStyle(
            fontSize: smallText,
          ),
        ),
      ],
    );
  }
}

class TooltipCustomBorder extends ShapeBorder {
  final double widgetPadding;

  const TooltipCustomBorder({this.widgetPadding = 0});

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(bottom: widgetPadding);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) => Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final rectWithNoBottomPadding = Rect.fromPoints(
      rect.topLeft,
      rect.bottomRight - Offset(0, widgetPadding),
    );
    return Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          rectWithNoBottomPadding,
          const Radius.circular(xsSize),
        ),
      )
      ..moveTo(
        rectWithNoBottomPadding.bottomCenter.dx - widgetPadding + 2,
        rectWithNoBottomPadding.bottomCenter.dy,
      )
      ..relativeLineTo(widgetPadding - 2, widgetPadding)
      ..relativeLineTo(widgetPadding - 2, -widgetPadding)
      ..close();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
