import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:prayer_time/ui/screen/home_screen.dart';
import 'package:prayer_time/ui/widget/background_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String appVersion='';
  @override
  void initState() {
    super.initState();
    _packageInfo();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 2));
    if(mounted){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>HomeScreen()));
    }
  }

  Future<void>_packageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
     appVersion = packageInfo.version;
     setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
             CupertinoActivityIndicator(color: Colors.white,radius: 18,),
              const SizedBox(height: 8),
              Text('Version : $appVersion',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
