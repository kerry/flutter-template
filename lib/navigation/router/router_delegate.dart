import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/modules/home/home_page.dart';
import 'package:flutter_template/modules/login/login_page.dart';
import 'package:flutter_template/modules/splash/splash_page.dart';
import 'package:flutter_template/navigation/app_state.dart';
import 'package:flutter_template/navigation/page_constants.dart';
import 'package:flutter_template/navigation/pages.dart';

class AppRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  final List<MaterialPage> _pages = [];

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final AppState appState;

  AppRouterDelegate(this.appState) : navigatorKey = GlobalKey() {
    appState.addListener(() {
      notifyListeners();
    });
  }

  // List<MaterialPage> get pages => List.unmodifiable(_pages);
  int numPages() => _pages.length;

  @override
  PageConfiguration? get currentConfiguration =>
      _pages.isEmpty ? null : _pages.last.arguments as PageConfiguration?;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _onPopPage,
      pages: buildPages(context),
    );
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) {
    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments as PageConfiguration).uiPage !=
            configuration.uiPage;
    if (shouldAddPage) {
      _pages.clear();
      addPage(configuration);
    }
    return SynchronousFuture(null);
  }

  @override
  Future<bool> popRoute() {
    if (canPop()) {
      _removePage(_pages.last);
      return Future.value(true);
    }
    return Future.value(false);
  }

  List<Page> buildPages(BuildContext context) {
    // if (_pages.isEmpty) {
    //   addPage(SplashPageConfig);
    //   return List.of(_pages);
    // }
    switch (appState.currentAction.state) {
      case PageState.none:
        break;
      case PageState.addPage:
        if (appState.currentAction.page != null) {
          _setPageAction(appState.currentAction);
          addPage(appState.currentAction.page!);
        }
        break;
      case PageState.pop:
        pop();
        break;
      case PageState.replace:
        if (appState.currentAction.page != null) {
          _setPageAction(appState.currentAction);
          replace(appState.currentAction.page!);
        }
        break;
      case PageState.replaceAll:
        if (appState.currentAction.page != null) {
          _setPageAction(appState.currentAction);
          replaceAll(appState.currentAction.page!);
        }
        break;
      case PageState.addWidget:
        if (appState.currentAction.page != null &&
            appState.currentAction.widget != null) {
          _setPageAction(appState.currentAction);
          pushWidget(
              appState.currentAction.widget!, appState.currentAction.page!);
        }
        break;
      case PageState.addAll:
        if (appState.currentAction.pages != null) {
          addAll(appState.currentAction.pages!);
        }
        break;
    }

    appState.resetCurrentAction();
    print(_pages);
    return List.of(_pages);
  }

  void addPage(PageConfiguration pageConfig) {
    // 1
    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments as PageConfiguration).uiPage !=
            pageConfig.uiPage;

    if (shouldAddPage) {
      switch (pageConfig.uiPage) {
        case Pages.Splash:
          _addPageData(SplashPage(), SplashPageConfig);
          break;
        case Pages.Login:
          _addPageData(LoginPage(), LoginPageConfig);
          break;
        case Pages.Home:
          _addPageData(HomePage(), HomePageConfig);
          break;
        default:
          break;
      }
    }
  }

  void pop() {
    if (canPop()) {
      _removePage(_pages.last);
    }
  }

  bool canPop() {
    return _pages.length > 1;
  }

  void replace(PageConfiguration newRoute) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }
    addPage(newRoute);
  }

  void setPath(List<MaterialPage> path) {
    _pages.clear();
    _pages.addAll(path);
  }

  void replaceAll(PageConfiguration newRoute) {
    setNewRoutePath(newRoute);
  }

  void push(PageConfiguration newRoute) {
    addPage(newRoute);
  }

  void pushWidget(Widget child, PageConfiguration newRoute) {
    _addPageData(child, newRoute);
  }

  void addAll(List<PageConfiguration> routes) {
    _pages.clear();
    routes.forEach((route) {
      addPage(route);
    });
  }

  MaterialPage _createPage(Widget child, PageConfiguration pageConfig) {
    return MaterialPage(
        child: child,
        key: ValueKey(pageConfig.key),
        name: pageConfig.path,
        arguments: pageConfig);
  }

  void _addPageData(Widget child, PageConfiguration pageConfig) {
    _pages.add(
      _createPage(child, pageConfig),
    );
  }

  bool _onPopPage(Route<dynamic> route, result) {
    print("calling pop");
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }
    if (canPop()) {
      pop();
      return true;
    } else {
      return false;
    }
  }

  void _removePage(MaterialPage page) {
    _pages.remove(page);
  }

  void _setPageAction(PageAction action) {
    switch (action.page?.uiPage) {
      case Pages.Splash:
        SplashPageConfig.currentPageAction = action;
        break;
      case Pages.Login:
        LoginPageConfig.currentPageAction = action;
        break;
      case Pages.Home:
        HomePageConfig.currentPageAction = action;
        break;
      default:
        break;
    }
  }
}
