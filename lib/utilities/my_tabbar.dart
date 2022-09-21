import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTabBar extends StatelessWidget {
  final List tabOptions; // [ "Recent", Widget ]
  const MyTabBar({
    Key? key,
    required this.tabOptions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          isScrollable: true,
          unselectedLabelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          indicator: UnderlineTabIndicator(
            borderSide:
                BorderSide(color: Colors.black.withOpacity(0.5), width: 2),
            insets: const EdgeInsets.symmetric(horizontal: 48),
          ),
          unselectedLabelColor: Colors.grey.withOpacity(0.5),
          labelColor: Colors.white.withOpacity(0.9),
          labelStyle: GoogleFonts.bebasNeue(
            fontSize: 32,
          ),
          //isScrollable: true,
          tabs: [
            Tab(
              child: Text(
                tabOptions[0][0],
              ),
            ),
            Tab(
              child: Text(
                tabOptions[1][0],
              ),
            ),
            Tab(
              child: Text(
                tabOptions[2][0],
              ),
            ),
            Tab(
              child: Text(
                tabOptions[3][0],
              ),
            ),
            Tab(
              child: Text(
                tabOptions[4][0],
              ),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            children: [
              tabOptions[0][1],
              tabOptions[1][1],
              tabOptions[2][1],
              tabOptions[3][1],
              tabOptions[4][1],
            ],
          ),
        )
      ],
    );
  }
}
