import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lykke_mobile_mavn/app/resources/unlocalized_strings.dart';
import 'package:lykke_mobile_mavn/feature_debug_menu/bloc/debug_menu_bloc.dart';

class ExpireSessionSettings extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final debugMenuBloc = useDebugMenuBloc();

    return Column(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            UnlocalizedStrings.expireSessionSettingsDescription,
            style: TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(height: 12),
        InkWell(
          key: const Key('debugMenuExpireSessionButton'),
          onTap: () {
            debugMenuBloc.expireSession();
          },
          child: Container(
            decoration: BoxDecoration(border: Border.all(width: 1)),
            padding: const EdgeInsets.all(12),
            child: const Text(UnlocalizedStrings.expireSessionSettingsButton,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );
  }
}
