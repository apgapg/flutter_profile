//
// Generated file. Do not edit.
//

// ignore: unused_import
import 'dart:ui';

import 'package:firebase_analytics_web/firebase_analytics_web.dart';
import 'package:url_launcher_web/url_launcher_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(PluginRegistry registry) {
  FirebaseAnalyticsWeb.registerWith(registry.registrarFor(FirebaseAnalyticsWeb));
  UrlLauncherPlugin.registerWith(registry.registrarFor(UrlLauncherPlugin));
  registry.registerMessageHandler();
}
