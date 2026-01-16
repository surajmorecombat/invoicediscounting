import 'package:flutter/material.dart';
import 'package:invoicediscounting/src/constant/app_color.dart';

class MainLayout extends StatefulWidget {
  final Widget? bottomNavigationBar;
  final Widget? body;
  final bool? showDefaultBottom;
  final bool? showCurvedAppBar;
  final bool? showFloatingActionButton;
  final String? title;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;

  int ctx;
  MainLayout({
    super.key,
    this.bottomNavigationBar,
    this.showDefaultBottom = false,
    this.ctx = 0,
    this.showCurvedAppBar = false,
    this.body,
    this.showFloatingActionButton = false,
    this.title,
    this.appBar,
    this.backgroundColor,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double paddingFactor = screenWidth < 600 ? 0.05 : 0.03;

    return Scaffold(
      backgroundColor: backgroundColor,

      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: true,

      appBar: widget.appBar,

      body: widget.body,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:
          (widget.showFloatingActionButton == false)
              ? null
              : Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: paddingFactor * screenHeight,
                ),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 55,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        widget.title.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      bottomNavigationBar:
          (widget.showDefaultBottom != true)
              ? null
              : ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                child: BottomNavigationBar(
                  backgroundColor: whiteColor,
                  type: BottomNavigationBarType.fixed,

                  selectedFontSize: screenWidth * 0.03,
                  unselectedFontSize: screenWidth * 0.03,

                  selectedItemColor: onboardingTitleColor,
                  unselectedItemColor: Colors.grey,

                  selectedLabelStyle: TextStyle(
                    fontSize: screenWidth * 0.03,
                    fontWeight: FontWeight.w600,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: screenWidth * 0.03,
                    fontWeight: FontWeight.w400,
                  ),

                  currentIndex: widget.ctx,
                  onTap: (int value) async {
                    switch (value) {
                      case 0:
                        if (widget.ctx != 0) {
                          Navigator.pushNamed(context, '/invest');
                        }
                        break;
                      case 1:
                        if (widget.ctx != 1) {
                          Navigator.pushNamed(context, '/activity');
                        }
                        break;
                      case 2:
                        if (widget.ctx != 2) {
                          Navigator.pushNamed(context, '/portfolio');
                        }
                        break;

                      case 3:
                        if (widget.ctx != 3) {
                          Navigator.pushNamed(context, '/chat');
                        }
                        break;
                    }
                  },
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/icons/invest-light.png',
                        height: 24,
                        width: 24,
                      ),
                      activeIcon: Image.asset(
                        'assets/icons/invest-dark.png',
                        height: 24,
                        width: 24,
                      ),
                      label: 'Invest',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/icons/activity-light.png',
                        height: 24,
                        width: 24,
                      ),

                      activeIcon: Image.asset(
                        'assets/icons/activity-dark.png',
                        height: 24,
                        width: 24,
                      ),
                      label: 'Activity',
                    ),
                    BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/icons/portfolio-light.png',
                        height: 24,
                        width: 24,
                      ),
                      activeIcon: Image.asset(
                        'assets/icons/portfolio-dark.png',
                        height: 24,
                        width: 24,
                      ),
                      label: 'Portfolio',
                    ),

                      BottomNavigationBarItem(
                      icon: Image.asset(
                        'assets/icons/chat-light.png',
                        height: 24,
                        width: 24,
                      ),
                      activeIcon: Image.asset(
                        'assets/icons/chat-dark.png',
                        height: 24,
                        width: 24,
                      ),
                      label: 'ask',
                    ),
                  ],
                ),
              ),
    );
  }
}
