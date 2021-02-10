
import 'package:flutter/material.dart';
// import 'package:http/http.dart';

import 'dart:async';
// import 'package:intl/intl.dart';

// logic
import '../methods/calc.dart';

import '../widgets/main_post.dart';
import '../logic/fetch.dart';


List<Map> boxes = [];


class Pages extends StatefulWidget {
  @override
  PageState createState() {
    return PageState();
  }
}

class PageState extends State<Pages> with TickerProviderStateMixin {

  ScrollController scrollController = ScrollController();
  PageController pageController = PageController();

  List<Widget> widgets = [];
  double bottom = 0;
  Offset pos = Offset(0,0);
  List<Widget> pages;
  
  
  @override
  void initState() {
    super.initState();
    
    checkData();

    scrollController.addListener(() {

      for ( int i = 0; i<postList.length; i++ ) {
        boxes[i]['pos'] = boxes[i]['rect'].localToGlobal(Offset.zero);
        boxes[i]['bottom'] = boxes[i]['pos'].dy + boxes[i]['rect'].size.height;

        if ( boxes[i]['bottom'] > 0 && boxes[i]['pos'].dy < 100.vh()) {
          boxes[i]['visible'] = true;
        } else {
          boxes[i]['visible'] = false;
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    // pageController.dispose();

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
        boxes.add({ 'key': GlobalKey(), 'bottom': bottom, 'pos': pos, 'visible': false, 'rect': RenderBox });

        widgets.add(box( index: i, scrollController: scrollController, boxKey: boxes[i]['key'], post: postList[i] ));
      }

      setState(() {
        // stateReady = false;
      });

      Timer(Duration(milliseconds: 1000), () {
        for ( int i = 0; i<postList.length; i++ ) {
          boxes[i]['rect'] = boxes[i]['key'].currentContext.findRenderObject();
        }
      });
    }
  }

  Future<bool> awaitChange() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center( 
      child: Stack(
      overflow: Overflow.visible,
          children: <Widget>[
            
              SingleChildScrollView(
              controller: scrollController,
              child: Container(
              width: 92.vw(),
              child: Column(

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


          Positioned(

              bottom: 0,
              left: -4.vw(),
              height: 45,
              width: 100.vw(),
              child: Hero( 
                tag: 'navbar',
                flightShuttleBuilder:
                (BuildContext flightContext,
                  Animation<double> animation,
                  HeroFlightDirection flightDirection,
                  BuildContext fromHeroContext,
                BuildContext toHeroContext,) {

                  return Container(
                    child: toHeroContext.widget,
                  );
                },
                child: Container( 
                  color: Color(0xFF101312),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          if ( pageCount > 0 ) {
                            pageCount--;
                            boxes = [];
                            Navigator.pop(context);
                            posts.fetchData( context, '/pages',  pageCount < 1 ? '' : '&after=${ bookmarks[fetchLimit * pageCount] }' );
                          }
                        },
                        child: Image.asset('ass/icons/left_arrow.png', height: 16),
                      ),
                      FlatButton(
                        onPressed: () {
                          pageCount++;
                          boxes = [];
                          // Navigator.pop(context);
                          posts.fetchData( context, '/pages',  '&after=${ (postList[postsShowing] as Post).data.id }' );
                        },
                        child: Image.asset('ass/icons/right_arrow.png', height: 16),
                      ),
                      FlatButton(
                        onPressed: () {
                          fetchAfter = '';
                          boxes = [];
                          // Navigator.pop(context);
                          Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                        },
                        child: Image.asset('ass/icons/home.png', height: 16),
                      ),
                      FlatButton(
                        onPressed: () {
                          
                        },
                        child: Image.asset('ass/icons/settings.png', height: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



Widget box ({ int index, ScrollController scrollController, GlobalKey boxKey, Post post, Animation<Offset> offsetAnimation }) => AnimatedBuilder(

  animation: scrollController,
  child: Container(
      key: boxKey,
      margin: EdgeInsets.only(bottom: 40),
      child: postList[index],
    ),

  builder: (BuildContext context, Widget child) {

    return AnimatedContainer(
      duration: Duration( milliseconds: 400 ),
      curve: Curves.decelerate,

      transform: Matrix4(
                1,0,0,0,
                0,1,0,0,
                0,0,1,0,
                0,

                index != 0 && boxes[index-1]['bottom'] > 85.vh()?
                 15.vh() :
                index != postsShowing && boxes[index+1]['pos'].dy < 15.vh() ? 
                 -15.vh() : 0,

                0,1,
            ),
      child: child,
    );
  }
);

