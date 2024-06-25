import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/core/services/api_service.dart';
import 'package:medical_examination_app/core/services/secure_storage_service.dart';
import 'package:medical_examination_app/core/services/shared_pref_service.dart';
import 'package:medical_examination_app/core/services/stt_service.dart';
import 'package:medical_examination_app/features/auth/presentation/pages/login_page.dart';
import 'package:medical_examination_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:medical_examination_app/features/category/presentation/providers/category_provider.dart';
import 'package:medical_examination_app/features/home/presentation/pages/welcome_page.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/pages/add_care_sheet_page.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/pages/add_signal_page.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/pages/add_streatment_sheet_page.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/pages/clinical_service_request_page.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/pages/edit_care_sheet_page.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/pages/edit_streatment_sheet_page.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/pages/medical_examination_page.dart';
import 'package:medical_examination_app/features/medical_examine/presentation/providers/medical_examine_provider.dart';
import 'package:medical_examination_app/features/nutrition/presentation/pages/assign_nutrition_page.dart';
import 'package:medical_examination_app/features/nutrition/presentation/pages/nutrition_assignation_history_page.dart';
import 'package:medical_examination_app/features/nutrition/presentation/providers/nutrition_provider.dart';
import 'package:medical_examination_app/features/patient/presentation/pages/assign_service_page.dart';
import 'package:medical_examination_app/features/patient/presentation/pages/create_patient_profile.dart';
import 'package:medical_examination_app/features/patient/presentation/pages/search_patient_page.dart';
import 'package:medical_examination_app/features/patient/presentation/providers/patient_provider.dart';
import 'package:medical_examination_app/features/skeleton/providers/selected_page_provider.dart';
import 'package:medical_examination_app/features/skeleton/skeleton.dart';
import 'package:medical_examination_app/features/tool/presentation/pages/tool_page.dart';
import 'package:medical_examination_app/features/user/presentation/pages/account_setting_page.dart';
import 'package:medical_examination_app/features/user/presentation/pages/profile_page.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: "lib/.env");
  ApiService.init();
  STTService.init();
  await SharedPrefService.init();
  await SecureStorageService.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectedPageProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => PatientProvider()),
        ChangeNotifierProvider(create: (_) => MedicalExamineProvider()),
        ChangeNotifierProvider(create: (_) => NutritionProvider()),
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
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
            centerTitle: true,
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300, width: 2)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300, width: 2)),
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red, width: 2)),
            hintStyle: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.grey),
            labelStyle: Theme.of(context)
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
                  fontWeight: FontWeight.normal,
                ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          )),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: CircleBorder()),
          segmentedButtonTheme: SegmentedButtonThemeData(
            style: SegmentedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              selectedForegroundColor: Colors.white,
              selectedBackgroundColor: Colors.blue,
              side: const BorderSide(color: Colors.blue, width: 1.5),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            ),
          ),
          fontFamily: GoogleFonts.roboto().fontFamily,
        ),
        initialRoute: RouteNames.welcome,
        routes: {
          RouteNames.welcome: (context) => const WelcomePage(),
          RouteNames.login: (context) => const LoginPage(),
          RouteNames.home: (context) => const HomeScreen(),
          RouteNames.tools: (context) => const ToolPage(),
          RouteNames.profile: (context) => const ProfilePage(),
          RouteNames.accountSetting: (context) => const AccountSettingPage(),
          RouteNames.crePatientProfile: (context) =>
              const CreatePatientProfilePage(),
          RouteNames.searchPatients: (context) => const SearchPatientPage(),
          RouteNames.medialExamine: (context) => const MedicalExaminationPage(),
          RouteNames.addSignal: (context) => const AddSignalPage(),
          RouteNames.addStreatmentSheet: (context) =>
              const AddStreatmentSheetPage(),
          RouteNames.editStreatmentSheet: (context) =>
              const EditStreatmentSheetPage(),
          RouteNames.addCareSheet: (context) => const AddCareSheetPage(),
          RouteNames.editCareSheet: (context) => const EditCareSheetPage(),
          RouteNames.requestClinicalService: (context) =>
              const ClinicalServiceRequestPage(),
          RouteNames.assignService: (context) => const AssignServicePage(),
          RouteNames.assignNutrition: (context) => const AssignNutritionPage(),
          RouteNames.nutritionAssignationHistory: (context) =>
              const NutritionAssignationHistoryPage(),
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // void _checkLogin(BuildContext context) async {
  //   String? token = await SecureStorageService.secureStorage.read(key: 'token');
  //   if (token == null) {
  //     Navigator.pushReplacementNamed(context, RouteNames.welcome);
  //     return;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // _checkLogin(context);
    return const Skeleton();
  }
}
