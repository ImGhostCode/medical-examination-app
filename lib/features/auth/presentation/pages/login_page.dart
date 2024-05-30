import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/core/services/shared_pref_service.dart';
// import 'package:medical_examination_app/core/constants/constants.dart';
import 'package:medical_examination_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final SharedPreferences prefs = SharedPrefService.prefs;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  FocusNode passwordFocusNode = FocusNode();
  String user = '';
  String password = '';
  bool _obscureText = true;
  bool rememberMe = false;
  String? storedUser;

  @override
  void initState() {
    storedUser = prefs.getString('userName');
    if (storedUser != null) {
      user = storedUser!;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(passwordFocusNode);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng nhập'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tên tài khoản',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          initialValue: user,
                          decoration: const InputDecoration(
                            hintText: 'Nhập tên tài khoản của bạn',
                          ),
                          onChanged: (value) {
                            user = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập tên tài khoản của bạn';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mật khẩu',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          focusNode: passwordFocusNode,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            hintText: 'Nhập mật khẩu của bạn',
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                icon: Icon(_obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                          ),
                          onChanged: (value) {
                            password = value;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Vui lòng nhập mật khẩu của bạn';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              activeColor: Theme.of(context).primaryColor,
                              // fillColor: WidgetStatePropertyAll(
                              //     Theme.of(context).primaryColor),
                              value: rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  rememberMe = value!;
                                });
                              },
                            ),
                            const Text('Ghi nhớ tài khoản'),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Quên mật khẩu?',
                              style: TextStyle(color: Colors.blue)),
                        ),
                      ],
                    ),
                  ],
                )),
            const Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await Provider.of<AuthProvider>(context, listen: false)
                        .eitherFailureOrLogin(
                            dotenv.env['RD_KEY']!, user, password);
                    if (Provider.of<AuthProvider>(context, listen: false)
                            .failure !=
                        null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                              Provider.of<AuthProvider>(context, listen: false)
                                  .failure!
                                  .errorMessage,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.white)),
                        ),
                      );
                    } else {
                      if (rememberMe) {
                        await prefs.setString('userName', user);
                      } else {
                        await prefs.remove('userName');
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            Provider.of<AuthProvider>(context, listen: false)
                                .message,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      );
                      Navigator.pushNamed(context, RouteNames.home);
                    }
                  }
                },
                child:
                    Provider.of<AuthProvider>(context, listen: true).isLoading
                        ? const SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
                        : const Text('Đăng nhập'),
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     const Text('Bạn chưa có tài khoản?'),
            //     TextButton(
            //       onPressed: () {
            //         // Navigator.of(context).pushNamed('/register');
            //       },
            //       child: const Text('Đăng ký',
            //           style: TextStyle(color: Colors.blue)),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
