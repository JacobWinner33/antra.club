import 'package:antra/constants.dart';
import 'package:antra/constants/routes.dart';
import 'package:antra/enums/menu_action.dart';
import 'package:antra/services/auth/auth_service.dart';
import 'package:antra/tabs/clubs_tab.dart';
import 'package:antra/tabs/open_mic_tab.dart';
import 'package:antra/tabs/rave_tab.dart';
import 'package:antra/tabs/resturants_tab.dart';
import 'package:antra/tabs/trending_tab.dart';
import 'package:antra/utilities/glass_box.dart';
import 'package:antra/utilities/my_appbar.dart';
import 'package:antra/utilities/my_bottombar.dart';
import 'package:antra/utilities/my_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

Future<void> _handleRefresh() async {
  return await Future.delayed(const Duration(milliseconds: 1200));
}

class _MainViewState extends State<MainView> {
  void _searchButtonTapped() {}

  List tabOptions = const [
    ['Trending', TrendingTab()],
    ['Clubs', ClubsTab()],
    ['Rave', RaveTab()],
    ['Open Mic', OpenMicTab()],
    ['Resturants', ResturantsTab()],
  ];
  int _currentBottomIndex = 0;
  void _handleBottomIndexChange(int? index) {
    setState(() {
      _currentBottomIndex = index!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabOptions.length,
        child: Scaffold(
          extendBody: true,
          bottomNavigationBar: GlassBox(
            child: MyBottomBar(
              index: _currentBottomIndex,
              onTap: _handleBottomIndexChange,
            ),
          ),
          backgroundColor: Constants.kGreyColor,
          body: LiquidPullToRefresh(
            onRefresh: _handleRefresh,
            color: Colors.deepPurple[900],
            height: 300,
            backgroundColor: Colors.white.withOpacity(0.99),
            animSpeedFactor: 9,
            showChildOpacityTransition: false,
            child: ListView(
              children: [
                SizedBox(
                  height: 700,
                  child: MyTabBar(
                    tabOptions: tabOptions,
                  ),
                ),
                const SizedBox(
                  height: 65,
                ),
                Center(
                  child: MyAppBar(
                    title: 'Explore. Celebrate.',
                    onTap: _searchButtonTapped,
                    onSearchTap: () {},
                  ),
                ),
                PopupMenuButton(
                  onSelected: (value) async {
                    switch (value) {
                      case MenuAction.logout:
                        final shouldLogout = await showLogOutDialog(context);
                        if (shouldLogout) {
                          await AuthService.firebase().logOut();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            loginRoute,
                            (_) => false,
                          );
                        }
                    }
                  },
                  itemBuilder: (context) {
                    return const [
                      PopupMenuItem<MenuAction>(
                        value: MenuAction.logout,
                        child: Text('Log out'),
                      )
                    ];
                  },
                ),
                const SizedBox(
                  height: 120,
                )
              ],
            ),
          ),
        ));
  }

  Future<bool> showLogOutDialog(BuildContext context) {
    return showDialog<bool>(
        context: context,
        builder: ((context) {
          return AlertDialog(
            backgroundColor: Constants.kGreenColor.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            title: const Center(
              child: Text(
                'Sign out',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text('Leaving so soon?', style: TextStyle(color: Colors.white)),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text(
                  'No',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                },
                child: const Text(
                  'Log out',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          );
        })).then((value) => value ?? false);
  }
}
