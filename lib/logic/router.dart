import 'package:flutter/material.dart';
import '../main.dart';


bool closeRoute( BuildContext context, PostData data ) {
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
        // return MaterialPageRoute(builder: (_) => );
        return customRoute(ViewPost(data));
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
    transitionDuration: Duration(seconds: 1),
    reverseTransitionDuration: Duration(seconds: 1),

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
