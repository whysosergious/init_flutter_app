
import 'package:flutter/material.dart';

// import 'package:intl/intl.dart';

// logic
// import 'methods/calc.dart';
import 'logic/router.dart';

// typography
import 'typography/text_styles.dart';

// widgets
import 'widgets/home.dart';





void main() => runApp(MaterialApp(home: SafeArea( child: Root())));



Size viewportDims;
class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    viewportDims = MediaQuery.of(context).size;
    return MaterialApp (
      onGenerateRoute: CustomRouter.generateRoute,
      initialRoute: '/',
      theme: mainTheme(),
      home: Home(),
    );
  }
}



// class Comment extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.grey[900],
//       width: double.infinity,
//       padding: EdgeInsets.all(10.0),
//       // child: textStyle.comment('Comment text'),
//     );
//   }
// }