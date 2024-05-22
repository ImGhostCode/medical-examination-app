import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'custom_bottom_bar_icon_widget.dart';
import '../providers/selected_page_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottomBarWidget extends StatelessWidget {
  CustomBottomBarWidget({super.key});

  final List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      activeIcon: FaIcon(FontAwesomeIcons.stethoscope),
      icon: FaIcon(FontAwesomeIcons.stethoscope),
      label: 'Trang chủ',
    ),
    const BottomNavigationBarItem(
      activeIcon: Icon(Icons.medical_services),
      icon: Icon(Icons.medical_services_outlined),
      label: 'Công cụ',
    ),
    const BottomNavigationBarItem(
      activeIcon: Icon(Icons.account_circle),
      icon: Icon(Icons.account_circle_outlined),
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 10,
        showUnselectedLabels: true,
        items: items,
        currentIndex: selectedPage,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: const TextStyle(
          fontSize: 13,
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
        selectedLabelStyle: const TextStyle(
          fontSize: 14,
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
        onTap: (value) {
          Provider.of<SelectedPageProvider>(context, listen: false)
              .changePage(value);
        },
      ),
    );
  }
}
