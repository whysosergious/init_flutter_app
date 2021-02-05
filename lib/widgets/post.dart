
import 'package:flutter/material.dart';
import '../typography/text_styles.dart';


const String userThumb = 'https://i1.sndcdn.com/avatars-000714205285-8ez60r-t240x240.jpg';
String postThumb = 'https://i.pinimg.com/originals/51/0d/a9/510da98abbe03f7ff9a7ce6eb0f362e7.jpg';


/// returns either a post title or comment. [ title overrides comment ]
Widget textGroup({

  double paddingLeft=10.0,
  String userThumb = userThumb,
  String title,
  String comment='*comment',
  String user='*u/user',
  String timestamp='*time_stamp',
  String rating='*rating',
  bool isReply = false,
  Widget reply

}) => Container(

  color: Colors.grey[900],
  width: double.infinity,
  padding: EdgeInsets.only(top: 10.0, right: 10.0, bottom: 10.0, left: paddingLeft),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,

    children: <Widget>[
      Container(
        margin: EdgeInsets.only(bottom: 10.0, right: 10.0),
        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(24.0),
                  child: Image.network(userThumb, height: 24),
                ),

                SizedBox(width: 10.0),  // _MARGIN_

                Text(user, style: textStyle.details.custom(color: Colors.orange[700])),

                SizedBox(width: 10.0),  // _MARGIN_

                Text(timestamp, style: textStyle.details),
              ],
            ),
            Row(
              children: <Widget>[
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
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Image.asset('ass/icons/message_bubble.png', height: 20.0),

              SizedBox(width: 10.0),  // _MARGIN_

              Text(commentsCount, style: textStyle.stats),
            ],
          ),
          Row(
            children: <Widget>[
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


Widget selfText(String selftext) => Container(
  color: Colors.grey[900],
  width: double.infinity,
  padding: EdgeInsets.only(top: 10.0, right: 10.0, bottom: 10.0, left: 10.0),
  child: Column(
    children: <Widget>[
      Align(
        alignment: Alignment.topLeft,
        child: Text(selftext, style: textStyle.body),
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
  color: Color(0xFF101211).withOpacity(1),
  width: double.infinity,
  padding: EdgeInsets.only(top: 14.0, right: 16.0, bottom: 20.0, left: 10.0),
  // margin: EdgeInsets.only(bottom: 10.0),
  child: Center(
    child: Text('View More Comments', style: textStyle.stats.custom(fontSize: 15.5)
    ),
  ),
);