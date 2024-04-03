import 'package:flutter/material.dart';

import '../../../../core/utils/utils.dart';

class ViewallChart extends StatelessWidget {
  const ViewallChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          const Expanded(
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AmountIntervalText(
                      text: r'$5k',
                    ),
                    AmountIntervalText(
                      text: r'$4k',
                    ),
                    AmountIntervalText(
                      text: r'$3k',
                    ),
                    AmountIntervalText(
                      text: r'$2k',
                    ),
                    AmountIntervalText(
                      text: r'$1k',
                    ),
                    xsSeparator,
                  ],
                ),
                smallSeparator,
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MonthlyColumn(
                        total: 100,
                        monthText: '01',
                      ),
                      MonthlyColumn(
                        total: 24,
                        monthText: '02',
                      ),
                      MonthlyColumn(
                        total: 140,
                        monthText: '03',
                      ),
                      MonthlyColumn(
                        total: 82,
                        monthText: '04',
                      ),
                      MonthlyColumn(
                        total: 120,
                        monthText: '05',
                      ),
                      MonthlyColumn(
                        total: 170,
                        monthText: '06',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MonthlyColumn extends StatelessWidget {
  const MonthlyColumn({
    required this.total,
    required this.monthText,
    super.key,
  });

  final double total;
  final String monthText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: 8,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(mediumSize),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  height: constraints.maxHeight - total,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(smallSize),
                    gradient: buttonsGradient,
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
          monthText,
          style: const TextStyle(
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
