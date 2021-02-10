import 'package:flutter/material.dart';
import 'fetch.dart';
import '../widgets/home.dart';
import '../widgets/pages.dart';
import '../widgets/view_post.dart';


bool closeRoute( BuildContext context, [ PostData data ]) {
  data.viewing = false;

  Navigator.of(context).pop('Context closed');
  return false;
}

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Home());
      case '/post':
        PostData data = settings.arguments as PostData;
        return customRoute(ViewPost(data));
      case '/pages':
        return customRoute(Pages());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No content on ${settings.name}')),
                ));
    }
  }
}


Route<dynamic> customRoute( Widget destination ) {
  return PageRouteBuilder(
    opaque: false,
    transitionDuration: Duration(milliseconds: 400),
    reverseTransitionDuration: Duration(milliseconds: 400),

    pageBuilder:
    ( BuildContext context,
      Animation<double> animation,
    Animation<double> secondaryAnimation ) {

      return destination;

      // return Align(
      //   child: SizeTransition(
      //     sizeFactor: animation,
      //     child: ViewPost(data),
      //   ),
      // );
    },
    transitionsBuilder:
    ( BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    Widget child ) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: SizeTransition(
          axisAlignment: -1.0,
          sizeFactor: animation,
          child: child,
        ),
      );
    },
  );
}
