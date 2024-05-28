import 'package:flutter/material.dart';
import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AccountSettingPage extends StatelessWidget {
  const AccountSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Cài đặt tài khoản'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                title: const Text('Đổi mật khẩu'),
                leading: const Icon(Icons.lock_outline_rounded),
                onTap: () {
                  // Navigator.of(context).pushNamed(RouteList.changePasswordPage);
                },
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
              const SizedBox(height: 10),
              ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                title: const Text('Xoá tài khoản'),
                leading: const Icon(Icons.person_remove_outlined),
                onTap: () {
                  // Navigator.of(context).pushNamed(RouteList.changePasswordPage);
                },
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
              const SizedBox(height: 10),
              ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                title: const Text('Đăng xuất',
                    style: TextStyle(color: Colors.red)),
                leading: const Icon(Icons.logout, color: Colors.red),
                onTap: () async {
                  await Provider.of<AuthProvider>(context, listen: false)
                      .eitherFailureOrLogout();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      RouteNames.welcome, (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
