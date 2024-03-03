import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) => child
    // {
    //   final begin = Offset(1.0, 0.0); // Start position of the incoming page
    //   final end = Offset.zero; // End position of the incoming page
    //   final curve = Curves.easeInOut; // Transition curve

    //   final tween = Tween(begin: begin, end: end);
    //   final curvedAnimation = CurvedAnimation(
    //     parent: animation,
    //     curve: curve,
    //   );

    //   return SlideTransition(
    //     position: tween.animate(curvedAnimation),
    //     child: child,
    //   );
    // },
  );
}
