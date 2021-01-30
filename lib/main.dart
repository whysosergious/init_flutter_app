


// flutter is nothing without material design huh..
import 'package:flutter/material.dart';

// logic
import 'methods/calc.dart';

// typography
import 'typography/text_styles.dart';






void main() => runApp(

  MaterialApp(

    home: Body(),
  ),
);


/// variable used by CalculateViewportDims extension in 'methods/calc.dart'
Size viewportDims;

/// our main body widget ( for now )
class Body extends StatelessWidget {
  @override
  Widget build( BuildContext context ) {
    /// setting context size
    viewportDims = MediaQuery.of(context).size;

    return Scaffold(

      body: Center(

        child: ListView(
          children: [
            Post(),
            Post(),
            Post(),
            Post(),
            Post(),
            Post(),
            Post(),
            Post(),
            Post(),
            Post(),
          ]
        )
      ),
    );
  }
}


class Post extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.red,
      width: 94.vw(),
      margin: EdgeInsets.all(14.0),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Heading(),

          Image.network('https://i.pinimg.com/originals/51/0d/a9/510da98abbe03f7ff9a7ce6eb0f362e7.jpg'),
          Details(),
          Comment(),
        ],
      ),
    );
  }
}

class Heading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[900],
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,

        children:  [
          textStyle.title('This is the title of the post.'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textStyle.tiny('u/user'),

              textStyle.tiny('posted 2 hours ago'),
              textStyle.comment('75k'),
            ]
          ),
        ],
      ),
    );
  }
}

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[900],
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textStyle.tiny('num_comments'),

              textStyle.tiny('permalink'),
            ],
          ),
    );
  }
}


class Comment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[900],
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      child: textStyle.comment('Comment text'),
    );
  }
}