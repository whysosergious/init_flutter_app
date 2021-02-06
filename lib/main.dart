


// flutter is nothing without material design huh..
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
// import 'package:intl/intl.dart';

// logic
import 'methods/calc.dart';
import 'logic/router.dart';

// typography
import 'typography/text_styles.dart';

// widgets
import 'widgets/post_elements.dart';
import 'widgets/main_post.dart';



/// dev standard vars
const String userThumb = 'https://i1.sndcdn.com/avatars-000714205285-8ez60r-t240x240.jpg';
String postThumb = 'https://i.pinimg.com/originals/51/0d/a9/510da98abbe03f7ff9a7ce6eb0f362e7.jpg';


String subreddit = 'doggos';
String fetchLimit = '14';
PostList posts = new PostList();






class PostList {
  List json;
  List<PostData> list;
  List<Widget> widgets;

  void fetchData() {

    final response = http.get('https://www.reddit.com/r/$subreddit.json?limit=$fetchLimit&raw_json=1');
    response.then((res) {

      json = jsonDecode(res.body)['data']['children'];
      this.sort( this.json );
      postList = widgets;
    });
  }

  sort( List json ) async {
    this.list = [];
    this.widgets = [];
    for ( int i=0; i<this.json.length; i++ ) {
      this.list.add( PostData.createEntry( json[i]['data'] ) );
      this.widgets.add(Post(this.list[i]));
      // this.widgets.add(SizedBox(height: 20.0));    // _STATIC_MARGIN_
    }
  }
}


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
  bool imageLoaded = false;

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
                    child: GestureDetector(
                      onTap: () {
                        closeRoute(context, postData);
                      },
                      child: Container(
                        padding: EdgeInsets.only(top: 8, right: 11, bottom: 8, left: 9),
                        color: Colors.grey[900].withAlpha(177),
                        child: Image.asset('ass/icons/left_arrow.png'),
                      ),
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




void main() {


    runApp(

    MaterialApp(
      // showPerformanceOverlay: true,
      // initialRoute: '/home',
      // routes: <String, WidgetBuilder> {
      //   '/home': (BuildContext context) => Home(),
      //   // '/pages': (BuildContext context) => Pages(),
      //   // '/viewpost': (BuildContext context) => ViewPost(),
      // },

      onGenerateRoute: CustomRouter.generateRoute,
      initialRoute: '/',
      theme: mainTheme(),
      home: Home(),
    ),

  );


}

GlobalKey pageIndexedStackKey = new GlobalKey();

List<Map> boxes = [];
List<Widget> postList;
/// variable used by CalculateViewportDims extension in 'methods/calc.dart'
Size viewportDims;



/// our main body widget ( for now )
class Home extends StatefulWidget {
  @override
  HomeState createState() {

    return HomeState();
  }
}


class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController animatedController;
    Animation delayed0, delayed1, delayed2;


  @override
  void initState() {
    super.initState();

    posts.fetchData();
  }

  void dispose() {
    animatedController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// setting context size
    viewportDims = MediaQuery.of(context).size;

  int currentPage = 0;
  final List<Widget> pagesList = [
    Pages()
  ];


    return Scaffold(
      // resizeToAvoidBottomInset: true,
      // MediaQueryData.viewInsets
    // extendBody.type =,
// persistentFooterButtons: [
  // RaisedButton(onPressed: (){}),
// ],

       body: IndexedStack(
        sizing: StackFit.passthrough,
        key: pageIndexedStackKey,
        index: currentPage,
        children: pagesList,
      ),
      extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 10,
        elevation: 40,

        backgroundColor: Colors.black87,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      onTap: (index) {
        setState(() {
          // current_tab = index;
        });
      },
      currentIndex: currentPage,
      items: [
        BottomNavigationBarItem(
        // backgroundColor: Colors.green,
          icon: Image.asset('ass/icons/left_arrow.png', height: 16, width: 20.vw()),
          label: 'Prev',
        ),
        BottomNavigationBarItem(
          // backgroundColor: Colors.green,
          icon: Image.asset('ass/icons/right_arrow.png', height: 16, width: 20.vw()),
          label: 'Next',
        ),
        BottomNavigationBarItem(
          // backgroundColor: Colors.green,
          icon: Image.asset('ass/icons/right_arrow.png', height: 16, width: 20.vw()),
          label: 'Next',
        ),
        BottomNavigationBarItem(
          // backgroundColor: Colors.green,
          icon: Image.asset('ass/icons/left_arrow.png', height: 16, width: 20.vw()),
          label: 'Prev',
        ),
      ],
      ),


    );
  }
}

class Pages extends StatefulWidget {

  @override
  PageState createState() {

    return PageState();
  }
}



  bool viewingPost;




class PageState extends State<Pages> with TickerProviderStateMixin {
  List<Widget> list;
  ScrollController scrollController = ScrollController();

  List<int> initOffsets = [];
  List<Widget> widgets = [];
  double mod = 0;
  Offset pos = Offset(0,0);
  int selectedPageIndex;
  List<Widget> pages;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    checkData();

    pageController = PageController();



    scrollController.addListener(() {

      for ( int i = 0; i<postList.length; i++ ) {
        Offset pos = boxes[i]['rect'].localToGlobal(Offset.zero);
        if ( pos.dy > -50.vh() && pos.dy < 150.vh()) {
          boxes[i]['visible'] = true;
        } else {
          boxes[i]['visible'] = false;
        }
      }
    });
  }

  // @override
  void dispose() {
    scrollController.dispose();
    pageController.dispose();

    super.dispose();
  }

  // yes this is horrible but temporary...
  bool stateReady = false;
  void checkData() async {

    if (postList == null) {
      Timer(Duration(milliseconds: 1000), () {
        checkData();


      });
    } else {


      widgets = [];
      for ( int i = 0; i<postList.length; i++ ) {
        boxes.add({ 'key': GlobalKey(), 'mod': mod, 'pos': pos, 'visible': false, 'rect': RenderBox });

        widgets.add( postList[i] );
        widgets.add(box( index: i, scrollController: scrollController, boxKey: boxes[i]['key'] ));

      }


      setState(() {
        this.list = postList;
        stateReady = false;
      });
      stateReady = await awaitChange();
      Timer(Duration(milliseconds: 400), () {
        for ( int i = 0; i<postList.length; i++ ) {
          getRect(i);
        }


      });

    }
  }

  Future<bool> awaitChange() async {

    return true;
  }
  void getRect(int i) {
    // print(boxes[i]['key'].currentContext.findRenderObject());
    // print(boxes[i]['key']);
    boxes[i]['rect'] = boxes[i]['key'].currentContext.findRenderObject();
    // boxes[i]['pos'] = boxes[i]['rect'].localToGlobal(Offset.zero);
    // boxes[i]['rect'] = boxes[i]['rect'];
    // boxes[i]['init_y'] = boxes[i]['pos'].dy.toInt();
    // initOffsets.add(boxes[i]['init_y']);
    // Timer(Duration(milliseconds: 200), () {
      // getRect();
    // });
    // stateReadyGl = true;
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
       body: SingleChildScrollView(
      controller: scrollController,
      child: Center(
        child: Container(
          // height: double.infinity,
          width: 92.vw(),


        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          verticalDirection: VerticalDirection.up,
        children: [

            // PageView(
            //   controller: pageController,
            //   children: [
            //     ...widgets,
            //   ],
            // ),
            ...widgets,




          ],
          ),
          ),
        ),
      ),
    );
  }
}


bool stateReadyGl = false;


Widget box ({ int index, ScrollController scrollController, GlobalKey boxKey }) => AnimatedBuilder(

  animation: scrollController,
  child: Container(
      key: boxKey,

      // child: post,
    ),



  builder: (BuildContext context, Widget child) {


    if(boxes[index]['visible']) {
      boxes[index]['pos'] = boxes[index]['rect'].localToGlobal(Offset.zero);
      // print(boxes[index]['pos'].dy);

    }

    return AnimatedContainer(
        duration: Duration(milliseconds: 900),
        curve: Curves.easeOutCirc,
        height: 30,


        child: child,
    );
  }
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