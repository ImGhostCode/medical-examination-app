import 'package:flutter/material.dart';
import 'package:medical_examination_app/features/home/presentation/pages/home_page.dart';
import 'package:medical_examination_app/features/tool/presentation/pages/tool_page.dart';
import 'package:medical_examination_app/features/user/presentation/pages/profile_page.dart';
import 'package:provider/provider.dart';
import 'widgets/custom_bottom_bar_widget.dart';
import 'providers/selected_page_provider.dart';

List<Widget> pages = [HomePage(), ToolPage(), ProfilePage()];

class Skeleton extends StatelessWidget {
  const Skeleton({super.key});

  @override
  Widget build(BuildContext context) {
    int selectedPage = Provider.of<SelectedPageProvider>(context).selectedPage;
    return Scaffold(
      body: pages[selectedPage],
      bottomNavigationBar: CustomBottomBarWidget(),
    );
  }
}
