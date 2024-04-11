import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/utils.dart';
import '../../domain/entities/chart.dart';
import 'monthly_column.dart';

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
