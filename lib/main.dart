


// flutter is nothing without material design huh..
import 'package:flutter/material.dart';

// logic
import 'methods/calc.dart';

// typography
import 'typography/text_styles.dart';



/// dev standard vars
const String userThumb = 'https://i1.sndcdn.com/avatars-000714205285-8ez60r-t240x240.jpg';
String postThumb = 'https://i.pinimg.com/originals/51/0d/a9/510da98abbe03f7ff9a7ce6eb0f362e7.jpg';


void main() => runApp(

  MaterialApp(
    theme: mainTheme(),
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

        child: new SingleChildScrollView(
          child:Column(
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
            ],
          ),
        ),
      ),
    );
  }
}


class Post extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 94.vw(),
      margin: EdgeInsets.only(top: 10.0, bottom: 20.0),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          textGroup(title: 'Post title'),

          Image.network(postThumb),
          selfText(),
          detailsGroup(commentsCount: '2.4k Comments'),
          textGroup(comment: 'Comment text', rating: '66k'),
          textGroup(comment: 'Comment text'),
          loadMoreComments(),
        ],
      ),
    );
  }
}


/// returns either a post title or comment. [ title overrides comment ]
Widget textGroup({

  String userThumb = userThumb,
  String title,
  String comment='*comment',
  String user='*u/user',
  String timeStamp='*time_stamp',
  String rating='*rating'

}) => Container(

  color: Colors.grey[900],
  width: double.infinity,
  padding: EdgeInsets.all(10.0),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,

    children: [
      Container(
        margin: EdgeInsets.only(bottom: 10.0, right: 10.0),
        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24.0),
                  child: Image.network(userThumb, height: 24),
                ),

                SizedBox(width: 10.0),  // _MARGIN_

                Text(user, style: textStyle.details.custom(color: Colors.orange[700])),

                SizedBox(width: 20.0),  // _MARGIN_

                Text(timeStamp, style: textStyle.details),
              ],
            ),
            Row(
              children: [
                Image.asset('ass/icons/up_vote.png', height: 20.0),

                SizedBox(width: 7.0),  // _MARGIN_

                Text(rating, style: textStyle.stats.custom(fontSize: 15.5, color: Colors.white)),
              ],
            ),

          ],
        ),
      ),
      (title != null)
        ? Text(title, style: textStyle.title)
        : Text(comment, style: textStyle.bodySmall),
    ],
  ),
);

Widget detailsGroup({

  String commentsCount,

}) => Container(
  color: Colors.black45,
  // color: Colors.grey[900],
  width: double.infinity,
  padding: EdgeInsets.only(top: 10.0, right: 16.0, bottom: 10.0, left: 10.0),
  // margin: EdgeInsets.only(bottom: 10.0),
  child: Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset('ass/icons/message_bubble.png', height: 20.0),

              SizedBox(width: 10.0),  // _MARGIN_

              Text(commentsCount, style: textStyle.stats),
            ],
          ),
          Row(
            children: [
              Image.asset('ass/icons/reddit.png', height: 20.0),

              SizedBox(width: 10.0),  // _MARGIN_

              Text('Link', style: textStyle.details.custom(color: Colors.blue)),
            ],
          ),
        ],
      ),

      // SizedBox(height: 10.0),  // _MARGIN_

      // const SizedBox(
      //   width: 260.0,
      //   height: 1.0,
      //   child: const DecoratedBox(
      //     decoration: const BoxDecoration(
      //       color: Colors.black12,
      //     ),
      //   ),
      // ),
    ],
  ),
);


Widget selfText() => Container(
  color: Colors.grey[900],
  width: double.infinity,
  padding: EdgeInsets.only(top: 10.0, right: 10.0, bottom: 10.0, left: 10.0),
  child: Column(
    children: [
      Align(
        alignment: Alignment.topLeft,
        child: Text('Post text', style: textStyle.body),
      ),

      SizedBox(height: 4.0),  // _MARGIN_

      // const SizedBox(
      //   width: 260.0,
      //   height: 1.0,
      //   child: const DecoratedBox(
      //     decoration: const BoxDecoration(
      //       color: Colors.black12,
      //     ),
      //   ),
      // ),
    ],
  ),
);

Widget loadMoreComments() => Container(
  color: Colors.black54,
  width: double.infinity,
  padding: EdgeInsets.only(top: 14.0, right: 16.0, bottom: 20.0, left: 10.0),
  // margin: EdgeInsets.only(bottom: 10.0),
  child: Center(
    child: Text('View More Comments', style: textStyle.stats.custom(fontSize: 15.5)
    ),
  ),
);




class Comment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      // child: textStyle.comment('Comment text'),
    );
  }
}