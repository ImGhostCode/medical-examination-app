import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/features/auth/presentation/pages/login_page.dart';
import 'package:medical_examination_app/features/home/presentation/pages/welcome_page.dart';
import 'package:medical_examination_app/features/skeleton/providers/selected_page_provider.dart';
import 'package:medical_examination_app/features/skeleton/skeleton.dart';
import 'package:medical_examination_app/features/tool/presentation/pages/tool_page.dart';
import 'package:medical_examination_app/features/user/presentation/pages/account_setting_page.dart';
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
        themeMode: ThemeMode.light,
        theme: ThemeData(
            useMaterial3: true,
            primaryColor: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            brightness: Brightness.light,
            // primaryColorDark: Colors.blue,
            // primaryColorLight: Colors.blue[100],
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              // ···
              brightness: Brightness.light,
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              foregroundColor: Colors.black,
              scrolledUnderElevation: 0,
              titleTextStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              centerTitle: true,
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey.shade300, width: 2)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2)),
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey.shade300, width: 2)),
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2)),
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.grey),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            )),
            fontFamily: GoogleFonts.roboto().fontFamily),
        initialRoute: RouteNames.welcome,
        routes: {
          RouteNames.welcome: (context) => const WelcomePage(),
          RouteNames.login: (context) => const LoginPage(),
          RouteNames.home: (context) => const HomeScreen(),
          RouteNames.tools: (context) => const ToolPage(),
          RouteNames.profile: (context) => ProfilePage(),
          RouteNames.accountSetting: (context) => const AccountSettingPage(),
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
