import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prayer_time/ui/screen/main_screen.dart';
import 'package:prayer_time/ui/utility/assets_paths.dart';
import 'package:prayer_time/ui/widget/background_image.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(Duration(seconds: 2));
    if(mounted){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>MainScreen()));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Center(
          child: SvgPicture.asset(
            AssetPaths.appLogoSvg,
            width: 200,
          ),
        ),),
    );
  }
}
