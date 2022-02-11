import 'package:app_localization/src/config/app_color.dart';
import 'package:app_localization/src/config/localized_strings.dart';
import 'package:app_localization/src/localization/index.dart';
import 'package:app_localization/src/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:route_generator/route_generator.dart';

@AppRoute("login",description: 'login page route')
class LoginPage extends StatefulWidget {
  final String? data;
  final int val;
  const LoginPage( {Key? key, this.data,required this.val}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController editingController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);

    return Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                left: 16, right: 16, top: mq.padding.top + 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.mobile_friendly,
                      color: AppColor.primary,
                      size: 120,
                    ),
                    spacer(),
                    spacer(),
                    Text(
                      LocalizedStrings.headerLogin,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      LocalizedStrings.labelLogin,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 48,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 24),
                  child: Column(
                    children: [
                      AppTextField(
                        label: LocalizedStrings.placeholderEmail,
                        controller: editingController,
                      ),
                      spacer(),
                      AppTextField(
                        label: LocalizedStrings.placeholderPassword,
                        controller: passwordController,
                        obscureText: true,
                      ),
                      spacer(),
                      spacer(),
                      SizedBox(
                        width: 250,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              LocalizedStrings.buttonLogin,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                            )),
                      ),
                      spacer(),
                      Text(
                        LocalizedStrings.labelForgotPassword,
                        style: const TextStyle(
                          color: Colors.black38,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  SizedBox spacer() => const SizedBox(
        height: 16,
      );
}
