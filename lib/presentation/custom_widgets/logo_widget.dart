import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LogoSvg extends StatelessWidget {
  final String assetsConsts;
  const LogoSvg({super.key, required this.assetsConsts});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetsConsts,
      width: 150,
      height: 150,
      color: Colors.blue.shade400,
    );
  }
}
