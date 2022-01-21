import 'package:flutter/material.dart';

import '../page_constants.dart';
import '../pages.dart';

class AppRouterParser extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    String? location = routeInformation.location;
    if (location != null) {
      final uri = Uri.parse(location);
      if (uri.pathSegments.isEmpty) {
        return SplashPageConfig;
      }

      final path = '/' + uri.pathSegments[0];
      switch (path) {
        case SplashPath:
          return SplashPageConfig;
        case LoginPath:
          return LoginPageConfig;
        case HomePath:
          return HomePageConfig;
        default:
          return SplashPageConfig;
      }
    } else {
      return SplashPageConfig;
    }
  }

  @override
  RouteInformation restoreRouteInformation(PageConfiguration configuration) {
    switch (configuration.uiPage) {
      case Pages.Splash:
        return const RouteInformation(location: SplashPath);
      case Pages.Login:
        return const RouteInformation(location: LoginPath);
      case Pages.Home:
        return const RouteInformation(location: HomePath);
      default: return const RouteInformation(location: SplashPath);
    }
  }
}
