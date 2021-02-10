
import 'package:flutter/material.dart';
import '../widgets/post_elements.dart';
import '../widgets/main_post.dart';
import '../logic/fetch.dart';
import '../logic/router.dart';


class ViewPost extends StatelessWidget {
  final PostData postData;
  ViewPost(this.postData) {
    postData.viewing = true;
  }
  @override
  Widget build(BuildContext context) {
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
                    textGroup(comment: 'Comment text'),
                    textGroup(comment: 'Comment text'),
                    textGroup(comment: 'Comment text'),
                    textGroup(comment: 'Comment text'),
                    textGroup(comment: 'Comment text'),
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