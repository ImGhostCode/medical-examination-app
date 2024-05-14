import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/features/home/presentation/pages/welcome_page.dart';
import 'package:medical_examination_app/features/skeleton/providers/selected_page_provider.dart';
import 'package:medical_examination_app/features/skeleton/skeleton.dart';
import 'package:medical_examination_app/features/tool/presentation/pages/tool_page.dart';
import 'package:medical_examination_app/features/user/presentation/pages/profile_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectedPageProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true, primaryColor: Colors.blue),
        initialRoute: RouteNames.home,
        routes: {
          RouteNames.welcome: (context) => const WelcomePage(),
          RouteNames.home: (context) => const HomeScreen(),
          RouteNames.tools: (context) => const ToolPage(),
          RouteNames.profile: (context) => const ProfilePage(),
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Skeleton();
  }
}
