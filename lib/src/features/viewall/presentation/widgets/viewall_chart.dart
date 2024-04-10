import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/utils.dart';
import '../../domain/entities/chart.dart';
import '../../domain/entities/monthly_chart_data.dart';

class ViewallChart extends StatelessWidget {
  const ViewallChart({required this.chart, super.key});

  final ChartEntity chart;

  @override
  Widget build(BuildContext context) {
    final List<String> amountIntervalTexts =
        monthlyThresholdToAmountIntervalTexts(chart.maxMonthThreshold);
    final dateFormatter = DateFormat.yMMMM('en_US');
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: mediumSize,
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          smallSize,
          xsSize,
          smallSize,
          xsSize,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(smallSize),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 4),
              color: Color(0xffdddddd),
              blurRadius: 10,
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2.8,
        child: Column(
          children: [
            Text(
              //eg: 'Jan 2021 - April 2021',
              '${dateFormatter.format(chart.monthlyList.first.date)} - ${dateFormatter.format(chart.monthlyList.last.date)}',
              style: TextStyle(
                color: textDark.withOpacity(0.8),
                fontSize: smallText,
              ),
            ),
            Text(
              r'$3500.00',
              style: TextStyle(
                color: textDark.withOpacity(0.8),
                fontSize: mediumText,
                fontWeight: FontWeight.bold,
              ),
            ),
            xsSeparator,
            Expanded(
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (final amountIntervalText
                          in amountIntervalTexts.reversed)
                        AmountIntervalText(
                          text: amountIntervalText,
                        ),
                      const SizedBox(
                        height: 36,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (final chartMonth in chart.monthlyList)
                          MonthlyColumn(
                            monthData: chartMonth,
                            columnHeightFactor:
                                chartMonth.balance / chart.maxMonthThreshold,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewallChartLoading extends StatelessWidget {
  const ViewallChartLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: mediumSize,
        ),
        child: Container(
          padding: const EdgeInsets.fromLTRB(
            smallSize,
            xsSize,
            smallSize,
            xsSize,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(smallSize),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 4),
                color: Color(0xffdddddd),
                blurRadius: 10,
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2.8,
          child: Column(
            children: [
              Text(
                '01 Jan 2021 - 01 April 2021',
                style: TextStyle(
                  color: textDark.withOpacity(0.8),
                  fontSize: smallText,
                ),
              ),
              Text(
                r'$3500.00',
                style: TextStyle(
                  color: textDark.withOpacity(0.8),
                  fontSize: mediumText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              xsSeparator,
              Expanded(
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (int i = 0; i < 5; i++)
                          const AmountIntervalText(
                            text: r'$5k',
                          ),
                        xsSeparator,
                      ],
                    ),
                    smallSeparator,
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          for (int i = 0; i < 6; i++)
                            const MonthlyColumnLoading(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
      duration: const Duration(milliseconds: 1),
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
    return Column(
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
                return AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) => AnimatedContainer(
                    height: constraints.maxHeight *
                        widget.columnHeightFactor *
                        _animation.value,
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

class AmountIntervalText extends StatelessWidget {
  const AmountIntervalText({
    required this.text,
    super.key,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: textDark.withOpacity(0.8),
        fontSize: smallText,
      ),
    );
  }
}
