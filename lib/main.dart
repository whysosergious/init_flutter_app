


// flutter is nothing without material design huh..
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// logic
import 'methods/calc.dart';

// typography
import 'typography/text_styles.dart';



/// dev standard vars
const String userThumb = 'https://i1.sndcdn.com/avatars-000714205285-8ez60r-t240x240.jpg';
String postThumb = 'https://i.pinimg.com/originals/51/0d/a9/510da98abbe03f7ff9a7ce6eb0f362e7.jpg';


String subreddit = 'doggos';
String fetchLimit = '10';
PostList posts = new PostList();





class PostList {
  List json;
  List<PostData> list;
  List<Widget> widgets;

  Future<List<Widget>> fetchData() async {
    final response = await http.get('https://www.reddit.com/r/$subreddit.json?limit=$fetchLimit&raw_json=1');
    json = jsonDecode(response.body)['data']['children'];
    this.sort( this.json );
    return widgets;
  }

  void sort( List json ) {
    this.list = [];
    this.widgets = [];
    for ( int i=0; i<this.json.length; i++ ) {
      this.list.add( PostData.createEntry( json[i]['data'] ) );
      this.widgets.add(Post(this.list[i]));
    }
  }
}

class PostData {
  final String id;
  final String author;
  final String title;
  final String selftext;
  final int score;
  final int timeStamp;

  final List images;
  final bool isVideo;
  final String video;
  final int numComments;
  final String permalink;
  List comments;

  PostData({
    this.id,
    this.author,
    this.title,
    this.selftext,
    this.score,
    this.timeStamp,
    this.images,
    this.isVideo,
    this.video,
    this.numComments,
    this.permalink
  });

  factory PostData.createEntry( Map json ) {
    return PostData(
      id: json['id'],
      author: json['author'],
      title: json['title'],
      selftext: json['selftext'],
      score: json['score'],
      timeStamp: json['created_utc'].toInt(),
      images: json['preview'] != null ? json['preview']['images'] : [{"source": {"url": ""}}],    //**TEMP */
      isVideo: json['isVideo'],
      // video: json['secure_media']['reddit_video']['fallback_url'],
      numComments: json['num_comments'],
      permalink: json['permalink']
    );
  }
}

bool postOpen = false;
class SecondRoute extends StatelessWidget {
  final Widget post;
  SecondRoute(this.post);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

        child: new SingleChildScrollView(
          child: post,
        ),
      ),
    );
  }
}

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

    return new Scaffold(

      body: Center(

      child: new SingleChildScrollView(
        child: Page(),
        ),
      ),

    );
  }
}

class Page extends StatefulWidget {
  @override
  PageState createState() {
    return new PageState();
  }
}

class PageState extends State<Page> {
  List<Widget> postList = [];

  PageState() {
    posts.fetchData().then((val) => setState(() {
        postList = val;
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: postList,
    );
  }
}

class Post extends StatefulWidget {
  final PostData data;
  Post(this.data);
  @override
  PostState createState() {
    return new PostState(this);
  }
}

int postWidth = 94;
class PostState extends State<Post> {
  Post post;
  PostData data;
  // int postWidth = 94;

  PostState(post) {
    this.post = post;
    this.data = post.data;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {

          if ( postOpen ) {

            Navigator.pop(context);
          }
          if ( !postOpen ) {

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondRoute(post)),
            );
          }

          postOpen = postOpen ? false : true;
          postWidth = postOpen ? 100 : 94;

          // setState(() {
          //   postWidth = postOpen ? 100 : 94;
          // });
          print("Container clicked");
        },
        child: Container(
        width: postWidth.vw(),
        margin: EdgeInsets.only(top: 10.0, bottom: 20.0),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            textGroup(title: data.title, user: 'u/${data.author}', timeStamp: '${data.timeStamp}', rating: '${data.score}'),

            Image.network(data.images[0]['source']['url']),
            selfText(),
            detailsGroup(commentsCount: '${data.score} Comments'),
            textGroup(comment: 'Comment text', rating: '66k'),
            textGroup(comment: 'Comment text'),
            loadMoreComments(),
          ],
        ),
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
  String rating='*rating',
  bool isReply = false,
  Widget reply

}) => Container(

  color: Colors.grey[900],
  width: double.infinity,
  padding: EdgeInsets.all(10.0),
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

                SizedBox(width: 20.0),  // _MARGIN_

                Text(timeStamp, style: textStyle.details),
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


Widget selfText() => Container(
  color: Colors.grey[900],
  width: double.infinity,
  padding: EdgeInsets.only(top: 10.0, right: 10.0, bottom: 10.0, left: 10.0),
  child: Column(
    children: <Widget>[
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