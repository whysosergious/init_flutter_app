


// flutter is nothing without material design huh..
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
// import 'package:intl/intl.dart';

// logic
import 'methods/calc.dart';

// typography
import 'typography/text_styles.dart';

// widgets
import 'widgets/post.dart';



/// dev standard vars
const String userThumb = 'https://i1.sndcdn.com/avatars-000714205285-8ez60r-t240x240.jpg';
String postThumb = 'https://i.pinimg.com/originals/51/0d/a9/510da98abbe03f7ff9a7ce6eb0f362e7.jpg';


String subreddit = 'doggos';
String fetchLimit = '14';
PostList posts = new PostList();





List fbb = [];
class PostList {
  List json;
  List<PostData> list;
  List<Widget> widgets;
  List fb;

  Future<List<Widget>> fetchData() async {
    final response = await http.get('https://www.reddit.com/r/$subreddit.json?limit=$fetchLimit&raw_json=1');
    json = jsonDecode(response.body)['data']['children'];
    this.sort( this.json );
    return widgets;
  }

  void sort( List json ) {
    this.list = [];
    this.widgets = [];
    this.fb = [];
    for ( int i=0; i<this.json.length; i++ ) {
      this.list.add( PostData.createEntry( json[i]['data'] ) );
      this.widgets.add(Post(this.list[i]));
      // this.widgets.add(SizedBox(height: 20.0));    // _STATIC_MARGIN_
      this.fb.add( box );
    }
    fbb = this.fb;
  }
}


Widget box ({ ScrollController controller, GlobalKey boxKey, Offset position }) => AnimatedBuilder(
              animation: controller,
              child: Container(
                  // key: boxes['0']['key'],
                  key: boxKey,
                  width: 140,
                  height: 40,
                  color: Colors.red,
                ),



              builder: (BuildContext context, Widget child) {
                // if ( rect != null ) {
                //   position = rect.localToGlobal(Offset.zero);
                //   print(position.dy);
                // }

                return AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.decelerate,
                  height: controller.offset / 4 + 40,
                  width: 50,
                  color: Colors.green,
                  child: child,
                );
              },
            );

double redditStamp;

class PostData {
  final String id;
  final String author;
  final String title;
  final String selftext;
  final int score;
  final String timestamp;

  final List images;
  final bool isVideo;
  final String video;
  final int numComments;
  final String permalink;
  List comments;
  bool viewing = false;

  PostData({
    this.id,
    this.author,
    this.title,
    this.selftext,
    this.score,
    this.timestamp,
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
      timestamp: (json['created_utc'] as double).humanTimestamp(),
      images: json['preview'] != null ? json['preview']['images'] : [{"source": {"url": ""}}],    //**TEMP */
      isVideo: json['isVideo'],
      // video: json['secure_media']['reddit_video']['fallback_url'],
      numComments: json['num_comments'],
      permalink: json['permalink']
    );
  }
}

double currentUnixTimeStamp = DateTime.now().millisecondsSinceEpoch / 1000;
extension TimeStampFormat on double {
  String humanTimestamp() {
    double time = (currentUnixTimeStamp - this) / 60;

    String result = time > 107040 ? '${ time ~/ 107040 } years ago'
      : time > 53520 ? 'a year ago'
      : time > 8920 ? '${ time ~/ 1440 } months ago'
      : time > 4460 ? 'a month ago'
      : time > 2880 ? '${ time ~/ 1440 } days ago'
      : time > 1440 ? 'a day ago'
      : time > 120 ? '${ time ~/ 60 } hours ago'
      : time > 60 ? 'an hour ago'
      : time > 1 ? '${time.toInt()} minutes ago' : 'a minute ago' ;

    return result;
  }
}


class ViewPost extends StatelessWidget {
  final PostData postData;
  ViewPost(this.postData) {
    postData.viewing = true;
  }
  @override
  Widget build(BuildContext context) {
    viewingPost = true;
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0),
        body: Stack(
          children: <Widget>[

            Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Post(postData),
                    textGroup(comment: 'Comment text', rating: '66k'),
                    textGroup(comment: 'Comment text'),
                    loadMoreComments(),
                  ],
                ),
              ),
            ),

            Positioned(
              top: 24,
              left: 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  height: 36,
                  width: 36,

                  child: Hero(
                    tag: 'back-button_${postData.id}',
                    child: Container(
                      padding: EdgeInsets.only(top: 8, right: 11, bottom: 8, left: 9),
                      color: Colors.grey[900].withAlpha(177),
                      child: Image.asset('ass/icons/left_arrow.png'),
                    ),
                  ),
                )
              ),
            ),
          ],
        ),
      ),
      onWillPop: () async {
        closeRoute(context, postData);
        return false;
      }
    );
  }
}




void main() => runApp(
  MaterialApp(
    // initialRoute: '/home',
    // routes: <String, WidgetBuilder> {
    //   '/home': (BuildContext context) => Home(),
    //   // '/pages': (BuildContext context) => Pages(),
    //   // '/viewpost': (BuildContext context) => ViewPost(),
    // },
    theme: mainTheme(),
    home: Home(),
  ),
);


/// variable used by CalculateViewportDims extension in 'methods/calc.dart'
Size viewportDims;

/// our main body widget ( for now )
class Home extends StatelessWidget {
  @override
  Widget build( BuildContext context ) {
    /// setting context size
    viewportDims = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: 92.vw(),
          child: Pages(),
        ),
      ),
    );
  }
}

class Pages extends StatefulWidget {
  @override
  PageState createState() {
    fetch();
    return PageState();
  }
}

List<Widget> postList;
void fetch() {
  posts.fetchData().then((val) {
    postList = val;
  });
}

bool fetchNewData = true;
bool viewingPost;
class PageState extends State<Pages> {
  List<Widget> list = postList ?? <Widget>[Container(height: 50, width: 50)];
  ScrollController controller = ScrollController();

  Map<String, Map<String, dynamic>> boxes = Map<String, Map<String, dynamic>>();
  List<int> initOffsets = [];

  Offset position;
List<Widget> a = [];

RenderBox rect;
  // @override
  void initState() {
  super.initState();
    checkData();



// boxes = { '0': { 'key': GlobalKey() }};
boxes['0'] = { 'key': GlobalKey() };

    // controller.addListener(() {
      // height = (controller.offset ~/ 10).toDouble();


    // });
  }

  // @override
  void dispose() {
    super.dispose();
  }

// yes this is horrible but temporary...
  bool stateReady = true;
  void checkData() async {

    if (postList == null) {
      Timer(Duration(milliseconds: 100), () {
        checkData();
        for ( int i = 1; i<4; i++ ) {
        // boxes['$i'] = { 'key': GlobalKey() };
        print(i);
        a.add(this.list[i]);
        a.add(fbb[i](controller: controller, position: position, boxKey: boxes['0']['key']));
      }
      print(boxes);
      });
    } else {

      setState(() {
        this.list = postList;
        stateReady = true;
      });
      stateReady = await awaitChange();
      Timer(Duration(milliseconds: 400), () {
        getRect();
      });

    }
  }

  Future<bool> awaitChange() async {
    return true;
  }
  void getRect() {
    rect = boxes['0']['key'].currentContext.findRenderObject();
    position = rect.localToGlobal(Offset.zero);
    boxes['0']['rect'] = rect;
    boxes['0']['init_y'] = position.dy.toInt();
    initOffsets.add(boxes['0']['init_y']);
    // Timer(Duration(milliseconds: 200), () {
      // getRect();
    // });
  }

  @override
  Widget build(BuildContext context) {
    print('a');
    viewingPost = false;
    return SingleChildScrollView(
        controller: controller,
        child: Column(
        children: [


            ...a




          ],
          ),




    );
  }
}





bool closeRoute( BuildContext context, PostData data ) {
  data.viewing = false;
  print(data.viewing);
  Navigator.of(context).pop('Context closed');
  return false;
}

int postWidth = 94;
bool a = false;
class Post extends StatelessWidget {
  final PostData data;
  Post(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {


          if ( data.viewing ) {
            closeRoute(context, data);
          } else {
            data.viewing = true;
            print(data.viewing);
            Navigator.of(context).push(
              PageRouteBuilder(
                opaque: false,
                transitionDuration: Duration(seconds: 1),
                reverseTransitionDuration: Duration(seconds: 1),

                pageBuilder:
                ( BuildContext context,
                  Animation<double> animation,
                Animation<double> secondaryAnimation ) {
                  return ViewPost(data);
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
              ),
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  <Widget>[

            IntrinsicHeight(
              child: Row(
                children: <Widget>[

                  Hero(
                    tag: 'back-button-padding_${data.id}',
                    child: Container(
                      width: viewingPost ? 8.vw() : 0,
                      color: Colors.grey[900],
                    ),
                  ),

                  (() {
                    if ( !data.viewing ) {
                      return Container(
                        height: 0,
                        width: 0,
                        child: Hero(
                          tag: 'back-button_${data.id}',
                          child: Container(
                            padding: EdgeInsets.only(top: 8, right: 11, bottom: 8, left: 9),
                            color: Colors.grey[900].withAlpha(255),
                            child: Image.asset('ass/icons/left_arrow.png'),
                          ),
                        ),
                      );
                    } return Container();
                  })(),

                  Container(
                    width: 92.vw(),
                    child: Hero(
                      tag: 'title_${data.id}',
                      child: Material(
                        child: textGroup(title: data.title, user: 'u/${data.author}', timestamp: '${data.timestamp}', rating: '${data.score}'),
                      ),
                    ),
                  ),


                ],
              ),
            ),

            if ( data.images[0]['source']['url'] != '' )
              Hero(
                tag: 'hero-image_${data.id}',
                child: FadeInImage.assetNetwork(
                // height: data.images[0]['source']['height'].toDouble() / (data.images[0]['source']['width'] / postWidth.vw()),
                placeholder: 'ass/detail/loading_image.png',
                image: data.images[0]['source']['url'],
              ),
            ),

            Container(
              constraints: BoxConstraints(
                maxHeight: viewingPost ? double.infinity : 0,
              ),
              child: Hero(
                tag: 'selftext_${data.id}',
                flightShuttleBuilder:
                  (BuildContext flightContext,
                    Animation<double> animation,
                    HeroFlightDirection flightDirection,
                    BuildContext fromHeroContext,
                  BuildContext toHeroContext,) {

                    return SingleChildScrollView(
                      child: fromHeroContext.widget,
                    );
                  },
                child: Material(
                  child: selfText(data.selftext + 'Post text'),
                ),
              ),
            ),

            Hero(
              tag: 'details_${data.id}',
              child: Material( child: detailsGroup(commentsCount: '${data.score} Comments')),
            ),

          ],
        ),
      ),
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