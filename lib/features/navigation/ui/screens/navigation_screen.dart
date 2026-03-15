import 'package:flutter/material.dart';
import 'package:movies/features/navigation/ui/screens/tabs/explore/explore_tab.dart';
import 'package:movies/features/navigation/ui/screens/tabs/home/home_tab.dart';
import 'package:movies/features/navigation/ui/screens/tabs/profile/profile_tab.dart';
import 'package:movies/features/navigation/ui/screens/tabs/search/search_tab.dart';
import 'package:movies/core/utils/app_assets.dart';
import 'package:movies/core/utils/app_colors.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});
  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}
class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;
  List<Widget> tabs = [HomeTab(), SearchTab(), ExploreTab(), ProfileTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomNavigationBar(),
      body: tabs[_selectedIndex],
    );
  }

  Widget buildBottomNavigationBar() {
    return Theme(
      data: ThemeData(
        canvasColor: AppColors.softBlack,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          unselectedItemColor: AppColors.white,
          selectedItemColor: AppColors.lightOrange,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          onTap: (index) {
            _selectedIndex = index;
            setState(() {});
          },
          items: [
            buildBottomNavigationBarItem(
              ImageIcon(AssetImage(AppAssets.iconHome)),
              "Home",
            ),
            buildBottomNavigationBarItem(
              ImageIcon(AssetImage(AppAssets.iconSearch)),
              "Search",
            ),
            buildBottomNavigationBarItem(
              ImageIcon(AssetImage(AppAssets.iconExplore)),
              "Explore",
            ),
            buildBottomNavigationBarItem(
              ImageIcon(AssetImage(AppAssets.iconProfile)),
              "Profile",
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(
    Widget icon,
    String label,
  ) {
    return BottomNavigationBarItem(icon: icon, label: label);
  }
}
