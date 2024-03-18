import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/common_widgets/custom_appbar_button.dart';
import '../../../../core/utils/utils.dart';
import '../../data/datasources/home_firebase_datasource.dart';
import '../../data/datasources/home_firestore_datasource.dart';
import '../../data/repositories/account_repository_impl.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          xlSeparator,
          Padding(
            padding: const EdgeInsets.only(
              left: mediumSize,
              right: mediumSize,
              top: mediumSize,
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                    'http://192.168.100.48:9199/v0/b/expense-tracker-app-bloc.appspot.com/o/profile-photos%2Fprofile-man-1.png?alt=media&token=3bb874e8-b353-4493-a71a-fd4886175fe1',
                  ),
                ),
                smallSeparator,
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome!',
                      style: TextStyle(
                        fontSize: smallText,
                      ),
                    ),
                    Text(
                      'John Doe',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textDark,
                      ),
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                CustomAppbarButton(
                  onTap: () async {
                    final response = await AccountRepositoryImpl(
                      HomeFirebaseDataSourceImpl(FirebaseAuth.instance),
                      HomeFirestoreDataSourceImpl(FirebaseFirestore.instance),
                    ).fetchAccount();
                    // HomeFirestoreDataSourceImpl(FirebaseFirestore.instance)
                    //     .deleteExpense(
                    //   'TmQC7eMDpnDECxVepvSD8xAhFlSu',
                    //   'default',
                    //   ExpenseDto(
                    //     category: 'ceava',
                    //     description: 'test',
                    //     amount: 100,
                    //     date: DateTime.now(),
                    //   ),
                    // );
                  },
                  icon: Icons.mode_standby,
                ),
              ],
            ),
          ),
          smallSeparator,
          Padding(
            padding: const EdgeInsets.only(
              left: mediumSize,
              right: mediumSize,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: mediumSize,
                horizontal: smallSize,
              ),
              decoration: BoxDecoration(
                gradient: buttonsGradient,
                borderRadius: BorderRadius.circular(mediumSize),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(-4, 6),
                    color: Color(0xffc4c4c4),
                    blurRadius: 10,
                  ),
                ],
              ),
              height: 200,
              width: double.infinity,
              child: const Column(
                children: [
                  Text(
                    'Total Balance',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  xsSeparator,
                  Text(
                    r'$ 4800.00',
                    style: TextStyle(
                      fontSize: largeText,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IncomeRow(),
                      ExpenseRow(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          mediumSeparator,
          Padding(
            padding: const EdgeInsets.only(
              left: mediumSize,
              right: mediumSize,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Transactions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    overlayColor: MaterialStatePropertyAll(
                      textDark.withOpacity(0.15),
                    ),
                  ),
                  child: const Text(
                    'View All',
                    style: TextStyle(
                      color: textDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(smallSize),
              itemCount: 20,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(smallSize),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(smallSize),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0, 6),
                        color: Color(0xffdddddd),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  height: 80,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(xsSize),
                        decoration: BoxDecoration(
                          color: const Color(0xffffc54d),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: const Icon(
                          Icons.shopping_bag,
                          color: Colors.white,
                          size: mediumSize,
                        ),
                      ),
                      xsSeparator,
                      const Text(
                        'Food',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            r'-$45.00',
                          ),
                          Text(
                            'Today',
                            style: TextStyle(
                              fontSize: 12,
                              color: textDark.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return smallSeparator;
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: CircleBorder(),
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: buttonsGradientReversed,
          ),
          child: const Icon(
            Icons.add,
            size: largeSize,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        padding: const EdgeInsets.symmetric(horizontal: xlSize),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(largeSize),
            topRight: Radius.circular(largeSize),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.grid_view_rounded,
              size: mediumSize + 4,
              color: textDark.withOpacity(0.4),
            ),
            Icon(
              Icons.expand_circle_down,
              size: mediumSize + 4,
              color: textDark.withOpacity(0.4),
            ),
          ],
        ),
      ),
    );
  }
}

class IncomeRow extends StatelessWidget {
  const IncomeRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0x33f4f4f4),
            borderRadius: BorderRadius.circular(99),
          ),
          child: const Icon(
            Icons.arrow_downward,
            color: Color(0xff3fe444),
            size: 18,
          ),
        ),
        xsSeparator,
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Income',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
            Text(
              '2500.00',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}

class ExpenseRow extends StatelessWidget {
  const ExpenseRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Expenses',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
            Text(
              '1700.00',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        xsSeparator,
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0x33f4f4f4),
            borderRadius: BorderRadius.circular(99),
          ),
          child: const Icon(
            Icons.arrow_upward,
            color: Color(0xfffb5d67),
            size: 18,
          ),
        ),
      ],
    );
  }
}
