import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:prayer_time/ui/utility/assets_paths.dart';
class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Stack(
      children: [
        SvgPicture.asset(
          AssetPaths.backgroundSvg,
          height: size.height,
          width: size.width,
          fit: BoxFit.fitHeight,
        ),
        child
      ],
    );
    ;
  }
}
