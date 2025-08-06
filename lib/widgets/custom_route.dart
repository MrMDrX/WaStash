import 'package:flutter/cupertino.dart';
import 'package:heroine/heroine.dart';

class CustomRoute<T> extends PageRoute<T>
    with CupertinoRouteTransitionMixin, HeroinePageRouteMixin {
  CustomRoute({
    required this.title,
    required this.builder,
    required bool fullscreenDialog,
  }) : _fullscreenDialog = fullscreenDialog;

  @override
  final String title;

  final Widget Function(BuildContext context) builder;

  final bool _fullscreenDialog;

  @override
  bool get fullscreenDialog => _fullscreenDialog;

  @override
  bool get maintainState => false;

  @override
  bool get opaque => false;

  @override
  Widget buildContent(BuildContext context) => builder(context);

  @override
  bool canTransitionTo(TransitionRoute nextRoute) {
    return super.canTransitionTo(nextRoute) ||
        nextRoute is CustomRoute && nextRoute.fullscreenDialog;
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return CupertinoRouteTransitionMixin.buildPageTransitions(
      this,
      context,
      animation,
      const AlwaysStoppedAnimation(0),
      child,
    );
  }
}
