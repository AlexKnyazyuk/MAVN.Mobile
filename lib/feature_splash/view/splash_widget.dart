import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lykke_mobile_mavn/app/resources/image_assets.dart';

class SplashWidget extends HookWidget {
  const SplashWidget();

  @override
  Widget build(BuildContext context) => Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Column(
        children: [
          const Spacer(flex: 1),
          Flexible(
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: Image.asset(
                ImageAssets.welcomePageImage,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const Spacer(flex: 2),
        ],
      ));
}
