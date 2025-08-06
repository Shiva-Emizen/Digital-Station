import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';

import '/auth/base_auth_user_provider.dart';

import '/main.dart';
import '/flutter_flow/flutter_flow_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? NavBarPage() : SplashPageWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? NavBarPage() : SplashPageWidget(),
        ),
        FFRoute(
            name: HomePageWidget.routeName,
            path: HomePageWidget.routePath,
            builder: (context, params) => params.isEmpty
                ? NavBarPage(initialPage: 'HomePage')
                : NavBarPage(
                    initialPage: 'HomePage',
                    page: HomePageWidget(),
                  )),
        FFRoute(
          name: SplashPageWidget.routeName,
          path: SplashPageWidget.routePath,
          builder: (context, params) => SplashPageWidget(),
        ),
        FFRoute(
          name: UserSelectionPageWidget.routeName,
          path: UserSelectionPageWidget.routePath,
          builder: (context, params) => UserSelectionPageWidget(),
        ),
        FFRoute(
          name: CreateAccountPageWidget.routeName,
          path: CreateAccountPageWidget.routePath,
          builder: (context, params) => CreateAccountPageWidget(),
        ),
        FFRoute(
          name: SelectPlanPageWidget.routeName,
          path: SelectPlanPageWidget.routePath,
          builder: (context, params) => SelectPlanPageWidget(),
        ),
        FFRoute(
          name: TermsConditionPageWidget.routeName,
          path: TermsConditionPageWidget.routePath,
          builder: (context, params) => TermsConditionPageWidget(),
        ),
        FFRoute(
          name: AccountPageWidget.routeName,
          path: AccountPageWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'AccountPage')
              : AccountPageWidget(),
        ),
        FFRoute(
          name: LanguagePageWidget.routeName,
          path: LanguagePageWidget.routePath,
          builder: (context, params) => LanguagePageWidget(),
        ),
        FFRoute(
          name: CategoryPageWidget.routeName,
          path: CategoryPageWidget.routePath,
          builder: (context, params) => CategoryPageWidget(),
        ),
        FFRoute(
          name: SubCategoryWidget.routeName,
          path: SubCategoryWidget.routePath,
          builder: (context, params) => SubCategoryWidget(
            categoryName: params.getParam(
              'categoryName',
              ParamType.String,
            ),
            categoryId: params.getParam(
              'categoryId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: OrderPageWidget.routeName,
          path: OrderPageWidget.routePath,
          builder: (context, params) => OrderPageWidget(),
        ),
        FFRoute(
          name: RequestEditPageWidget.routeName,
          path: RequestEditPageWidget.routePath,
          builder: (context, params) => RequestEditPageWidget(
            orderId: params.getParam(
              'orderId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: OrdersPageWidget.routeName,
          path: OrdersPageWidget.routePath,
          builder: (context, params) => OrdersPageWidget(),
        ),
        FFRoute(
          name: SavedPageWidget.routeName,
          path: SavedPageWidget.routePath,
          builder: (context, params) => SavedPageWidget(),
        ),
        FFRoute(
          name: ServicePageWidget.routeName,
          path: ServicePageWidget.routePath,
          builder: (context, params) => ServicePageWidget(
            categoryId: params.getParam(
              'categoryId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: ProfilePageWidget.routeName,
          path: ProfilePageWidget.routePath,
          builder: (context, params) => ProfilePageWidget(),
        ),
        FFRoute(
          name: CompleteProfilePageWidget.routeName,
          path: CompleteProfilePageWidget.routePath,
          builder: (context, params) => CompleteProfilePageWidget(
            userId: params.getParam(
              'userId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: SubscriptionPageWidget.routeName,
          path: SubscriptionPageWidget.routePath,
          builder: (context, params) => SubscriptionPageWidget(),
        ),
        FFRoute(
          name: CreateOrderWidget.routeName,
          path: CreateOrderWidget.routePath,
          builder: (context, params) => CreateOrderWidget(
            serviceId: params.getParam(
              'serviceId',
              ParamType.String,
            ),
            packageId: params.getParam(
              'packageId',
              ParamType.String,
            ),
            price: params.getParam(
              'price',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: PersonalInformationPageWidget.routeName,
          path: PersonalInformationPageWidget.routePath,
          builder: (context, params) => PersonalInformationPageWidget(),
        ),
        FFRoute(
          name: WorkInformationPageWidget.routeName,
          path: WorkInformationPageWidget.routePath,
          builder: (context, params) => WorkInformationPageWidget(),
        ),
        FFRoute(
          name: SelectSubscriptionPageWidget.routeName,
          path: SelectSubscriptionPageWidget.routePath,
          builder: (context, params) => SelectSubscriptionPageWidget(),
        ),
        FFRoute(
            name: FreeLancerHomePageWidget.routeName,
            path: FreeLancerHomePageWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: FreeLancerHomePageWidget(),
                )),
        FFRoute(
          name: FreelancerOrderPageWidget.routeName,
          path: FreelancerOrderPageWidget.routePath,
          builder: (context, params) => FreelancerOrderPageWidget(),
        ),
        FFRoute(
          name: PortfolioPageWidget.routeName,
          path: PortfolioPageWidget.routePath,
          builder: (context, params) => PortfolioPageWidget(),
        ),
        FFRoute(
          name: MyPortFolioPageWidget.routeName,
          path: MyPortFolioPageWidget.routePath,
          builder: (context, params) => MyPortFolioPageWidget(),
        ),
        FFRoute(
          name: WalletPageWidget.routeName,
          path: WalletPageWidget.routePath,
          builder: (context, params) => WalletPageWidget(),
        ),
        FFRoute(
          name: PaymentPageWidget.routeName,
          path: PaymentPageWidget.routePath,
          builder: (context, params) => PaymentPageWidget(),
        ),
        FFRoute(
            name: MessagePageWidget.routeName,
            path: MessagePageWidget.routePath,
            builder: (context, params) => params.isEmpty
                ? NavBarPage(initialPage: 'MessagePage')
                : NavBarPage(
                    initialPage: 'MessagePage',
                    page: MessagePageWidget(),
                  )),
        FFRoute(
          name: NotificationPageWidget.routeName,
          path: NotificationPageWidget.routePath,
          builder: (context, params) => NotificationPageWidget(),
        ),
        FFRoute(
          name: MyServicePageWidget.routeName,
          path: MyServicePageWidget.routePath,
          builder: (context, params) => MyServicePageWidget(),
        ),
        FFRoute(
          name: AddNewServiceWidget.routeName,
          path: AddNewServiceWidget.routePath,
          builder: (context, params) => AddNewServiceWidget(),
        ),
        FFRoute(
          name: AddNewServiceNextPageWidget.routeName,
          path: AddNewServiceNextPageWidget.routePath,
          builder: (context, params) => AddNewServiceNextPageWidget(
            serviceId: params.getParam(
              'serviceId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: PublishServicePageWidget.routeName,
          path: PublishServicePageWidget.routePath,
          builder: (context, params) => PublishServicePageWidget(
            serviceId: params.getParam(
              'serviceId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: ServiceSuccessFullyPublishPageWidget.routeName,
          path: ServiceSuccessFullyPublishPageWidget.routePath,
          builder: (context, params) => ServiceSuccessFullyPublishPageWidget(),
        ),
        FFRoute(
          name: AddPakagePageWidget.routeName,
          path: AddPakagePageWidget.routePath,
          builder: (context, params) => AddPakagePageWidget(
            id: params.getParam(
              'id',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: AddFaqPageWidget.routeName,
          path: AddFaqPageWidget.routePath,
          builder: (context, params) => AddFaqPageWidget(
            serviceId: params.getParam(
              'serviceId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: OtpPageWidget.routeName,
          path: OtpPageWidget.routePath,
          builder: (context, params) => OtpPageWidget(
            otp: params.getParam(
              'otp',
              ParamType.int,
            ),
            email: params.getParam(
              'email',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: ForgotPasswordPageWidget.routeName,
          path: ForgotPasswordPageWidget.routePath,
          builder: (context, params) => ForgotPasswordPageWidget(),
        ),
        FFRoute(
          name: ResetPasswordPageWidget.routeName,
          path: ResetPasswordPageWidget.routePath,
          builder: (context, params) => ResetPasswordPageWidget(
            email: params.getParam(
              'email',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: ServiceDetailPageWidget.routeName,
          path: ServiceDetailPageWidget.routePath,
          builder: (context, params) => ServiceDetailPageWidget(
            serviceId: params.getParam(
              'serviceId',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: ViewAllPageWidget.routeName,
          path: ViewAllPageWidget.routePath,
          builder: (context, params) => ViewAllPageWidget(),
        ),
        FFRoute(
          name: CreateAccountPageFreelancerWidget.routeName,
          path: CreateAccountPageFreelancerWidget.routePath,
          builder: (context, params) => CreateAccountPageFreelancerWidget(),
        ),
        FFRoute(
          name: LoginPageFreelancerWidget.routeName,
          path: LoginPageFreelancerWidget.routePath,
          builder: (context, params) => LoginPageFreelancerWidget(),
        ),
        FFRoute(
          name: OtpPageFreelancerWidget.routeName,
          path: OtpPageFreelancerWidget.routePath,
          builder: (context, params) => OtpPageFreelancerWidget(
            otp: params.getParam(
              'otp',
              ParamType.int,
            ),
            email: params.getParam(
              'email',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
            name: HomePageCopyWidget.routeName,
            path: HomePageCopyWidget.routePath,
            builder: (context, params) => NavBarPage(
                  initialPage: '',
                  page: HomePageCopyWidget(),
                )),
        FFRoute(
          name: EditPersonalInformationPageWidget.routeName,
          path: EditPersonalInformationPageWidget.routePath,
          builder: (context, params) => EditPersonalInformationPageWidget(),
        ),
        FFRoute(
          name: AllServiceWidget.routeName,
          path: AllServiceWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'AllService')
              : AllServiceWidget(),
        ),
        FFRoute(
          name: ViewFilePageWidget.routeName,
          path: ViewFilePageWidget.routePath,
          builder: (context, params) => ViewFilePageWidget(
            galleryList: params.getParam<dynamic>(
              'galleryList',
              ParamType.JSON,
              isList: true,
            ),
          ),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/splashPage';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Image.asset(
                      'assets/images/Splash_Screen.png',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
