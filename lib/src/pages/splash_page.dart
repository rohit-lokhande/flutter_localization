import 'package:app_localization/src/config/app_color.dart';
import 'package:app_localization/src/localization/index.dart';
import 'package:app_localization/src/pages/login_page.dart';
import 'package:app_localization/src/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3),(){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Icon(
              Icons.mobile_friendly,
              color: AppColor.white,
              size: 180,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 18),
            child: Text(
              AppLocalizations.of(context)!.find('app_title'),
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: AppColor.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
