import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:card_master/core/components/customtext.dart';
import 'package:card_master/core/constants/color_constants.dart';
import 'package:card_master/features/home_page/presentation/pages/homepage.dart';
import 'package:card_master/features/themes/theme_changer_page.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final int initialIndex;

  const BottomNavigation({super.key, required this.initialIndex});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final NotchBottomBarController _controller = NotchBottomBarController(
    index: 0,
  );
  late int selectedIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
    _controller.index = selectedIndex;
    _pageController = PageController(initialPage: selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _changePage(int index) {
    setState(() {
      selectedIndex = index;
      _controller.index = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screenList = [
      const Center(child: Text("Home")),
      const Center(child: Text("Calendar")),
      const HomePage(),
      const Center(child: CustomText(data: "Transaction History")),
      const ThemeChangerPage(),
    ];

    return WillPopScope(
      onWillPop: () async {
        if (selectedIndex != 2) {
          _changePage(2);
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: screenList,
        ),
        extendBody: true,
        backgroundColor: ColorConstants.backgroundColor,
        bottomNavigationBar: AnimatedNotchBottomBar(
          bottomBarHeight: 50,
          durationInMilliSeconds: 300,
          elevation: 2,
          kBottomRadius: 40.0,
          notchColor: ColorConstants.buttonColor,
          notchBottomBarController: _controller,
          color: ColorConstants.primaryWhite,

          kIconSize: 25,
          notchGradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.0, 0.10, 1.0],
            colors: [
              // Color(0xffFDFDFD),
              // Color.fromARGB(255, 129, 255, 215),
              Color(0xff4ECB84),
              Color(0xff2CB892),
              Color(0xff03A8A1),
            ],
          ),
          onTap: _changePage,
          bottomBarItems: [
            BottomBarItem(
              activeItem: Icon(
                Icons.home_filled,
                color: ColorConstants.primaryWhite,
              ),
              inActiveItem: Icon(Icons.home_outlined),
            ),
            BottomBarItem(
              activeItem: Icon(
                Icons.calendar_month_outlined,
                color: ColorConstants.primaryWhite,
              ),
              inActiveItem: Icon(Icons.calendar_month_outlined),
            ),
            BottomBarItem(
              activeItem: Icon(Icons.add, color: ColorConstants.primaryWhite),
              inActiveItem: Icon(Icons.add),
            ),

            BottomBarItem(
              activeItem: Icon(
                Icons.note_add_outlined,
                color: ColorConstants.primaryWhite,
              ),
              inActiveItem: Icon(Icons.note_add_rounded),
            ),
            BottomBarItem(
              activeItem: Icon(
                Icons.settings,
                color: ColorConstants.primaryWhite,
              ),
              inActiveItem: Icon(Icons.settings_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
