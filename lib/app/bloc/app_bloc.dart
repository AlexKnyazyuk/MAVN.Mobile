import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lykke_mobile_mavn/app/app.dart';
import 'package:lykke_mobile_mavn/base/dependency_injection/app_module.dart';
import 'package:lykke_mobile_mavn/base/remote_data_source/remote_config_manager/remote_config_manager.dart';
import 'package:lykke_mobile_mavn/base/router/router_page_factory.dart';
import 'package:lykke_mobile_mavn/base/router/router_page_names.dart';
import 'package:lykke_mobile_mavn/library_bloc/core.dart';
import 'package:pedantic/pedantic.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_bloc_output.dart';

export 'app_bloc_output.dart';

class AppBloc extends Bloc<AppState> {
  @override
  AppState initialState() => AppStateInitializing();

  Future<void> initializeApp({
    @required Environment environment,
    @required BuildContext context,
  }) async {
    final appModule = await _initAppModule(environment);

    await _setupRemoteConfigManager(appModule.remoteConfigManager);

    setState(AppStateInitialized(
      appModule: appModule,
      rootPageWidget: RouterPageFactory.getSplashPage(),
      rootPageName: RouterPageName.splashPage,
    ));
  }

  Future<AppModule> _initAppModule(Environment environment) async {
    final results =
        await Future.wait([_getSharedPreferences(), _getRemoteConfig()]);

    return AppModule(
      sharedPreferences: results[0],
      remoteConfig: results[1],
    );
  }

  Future<SharedPreferences> _getSharedPreferences() =>
      SharedPreferences.getInstance();

  Future<RemoteConfig> _getRemoteConfig() => RemoteConfig.instance;

  Future<void> _setupRemoteConfigManager(
      RemoteConfigManager remoteConfigManager) async {
    // init() blocks App start
    await remoteConfigManager.init();

    // fetchNewRemoteConfig() does NOT block App start, but give it a small
    // amount of time to complete before starting the app, maybe the internet
    // is fast enough
    unawaited(remoteConfigManager.fetchNewRemoteConfig());
    await Future.delayed(const Duration(seconds: 1));
  }
}

AppBloc useAppBloc() => Provider.of<AppBloc>(useContext());
