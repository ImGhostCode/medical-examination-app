import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'custom_bottom_bar_icon_widget.dart';
import '../providers/selected_page_provider.dart';

class CustomBottomBarWidget extends StatelessWidget {
  CustomBottomBarWidget({super.key});

  final List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      activeIcon: Icon(Icons.home),
      icon: Icon(Icons.home_outlined),
      label: 'Trang chủ',
    ),
    const BottomNavigationBarItem(
      activeIcon: Icon(Icons.construction),
      icon: Icon(Icons.construction),
      label: 'Công cụ',
    ),
    const BottomNavigationBarItem(
      activeIcon: Icon(Icons.person),
      icon: Icon(Icons.person_outline),
      label: 'Hồ sơ',
    ),
  ];

  // Provider.of<UserProvider>(context, listen:  false).userEntity.accountType == AccountType.admin ?

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    int selectedPage = Provider.of<SelectedPageProvider>(context).selectedPage;
    return SafeArea(
      child: BottomNavigationBar(
        elevation: 10,
        showUnselectedLabels: true,
        items: items,
        currentIndex: selectedPage,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (value) {
          Provider.of<SelectedPageProvider>(context, listen: false)
              .changePage(value);
        },
      ),
    );
  }
}
