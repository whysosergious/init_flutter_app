
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'dart:async';

import '../methods/calc.dart';
// import '../main.dart';
import '../widgets/main_post.dart';

/// dev standard vars
const String userThumb = 'https://i1.sndcdn.com/avatars-000714205285-8ez60r-t240x240.jpg';
String postThumb = 'https://i.pinimg.com/originals/51/0d/a9/510da98abbe03f7ff9a7ce6eb0f362e7.jpg';


String subreddit = 'doggos';
int fetchLimit = 14;
String fetchAfter = '';
int postsShowing = 0;
PostList posts = new PostList();
List<Widget> postList;


queryPage(BuildContext context, String route) {
    Navigator.pushNamed( context, '/pages' );
}

List<String> bookmarks = [];
int pageCount = 0;

class PostList {
  List json;
  List<PostData> list;
  List<Widget> widgets;

  Future fetchData(BuildContext context, String route, [ String after='' ]) async {
    try {
      dynamic response = http.get('https://www.reddit.com/r/$subreddit.json?limit=$fetchLimit&raw_json=1&$after');
   
      return await response.then((res) {
        json = jsonDecode(res.body)['data']['children'];
        this.sort( this.json );
        postList = widgets;
      }).then((res) => queryPage(context, route));
    } catch (err) { print(err); }
  }

  sort( List json ) async {
    this.list = [];
    this.widgets = [];
    postsShowing = this.json.length-1;
    for ( int i=0; i<=postsShowing; i++ ) {
      bookmarks.add( json[i]['data']['name'] );
     
      this.list.add( PostData.createEntry( json[i]['data'] ) );
      this.widgets.add(Post(this.list[i]));
      // this.widgets.add(SizedBox(height: 20.0));    // _STATIC_MARGIN_
    }
  }
}

class PostData {
  final String id;
  final String author;
  final String title;
  final String selftext;
  final String score;
  final String timestamp;

  final List images;
  final bool isVideo;
  final String video;
  final int numComments;
  final String permalink;
  final List album;
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
    this.album,
    this.images,
    this.isVideo,
    this.video,
    this.numComments,
    this.permalink
  });

  factory PostData.createEntry( Map json ) {
    return PostData(
      id: json['name'],
      author: json['author'],
      title: json['title'],
      selftext: json['selftext'],
      score: formatScore(json['score'].toString()),
      timestamp: (json['created_utc'] as double).humanTimestamp(),
      images: json['preview'] != null ? json['preview']['images'] : [{"source": {"url": ""}}],    //**TEMP */
      // album: json['gallery_data'] as List<dynamic>,
      isVideo: json['isVideo'],
      // video: json['secure_media']['reddit_video']['fallback_url'],
      numComments: json['num_comments'],
      permalink: json['permalink']
    );
  }
}

String formatScore(String str) {   
  String result;
    if ((str != null) && (str.length >= 3)) {      
    	result = '${ str.substring(0, str.length - 2) }k';
    } else { result = str; }
    return result;
}




// class CommentData {
//   final String id;
//   final String author;
//   final String title;
//   final String body;
//   final String score;
//   final String timestamp;
//   final String permalink;
//   final int numComments;


//   CommentData({
//     this.id,
//     this.author,
//     this.title,
//     this.body,
//     this.score,
//     this.timestamp,
//     this.permalink, 
//     this.numComments,
    
//   });


//   factory CommentData.createEntry( Map json ) {
//     return CommentData(
//       id: json['name'],
//       author: json['author'],
//       title: json['title'],
//       body: json['body'],
//       score: formatScore(json['score'].toString()),
//       timestamp: (json['created_utc'] as double).humanTimestamp(),

//       numComments: json['num_comments'],
//       permalink: json['permalink'],
//     );
//   }
// }




// Future fetchComments(BuildContext context, String route, [ String after='' ]) async {
//   try {
//     dynamic res = http.get('https://www.reddit.com/r/aww/comments/lfqkw6/.json?');
  

// final items = json.decode(res.body) as List;
// final x = items.expand((p) => p['items']);
// print(x);


//     return await res.then((res) {
//       // json = jsonDecode(res.body)['data']['children'];
//       // this.sort( this.json );
//       // postList = widgets;
//     }).then((res) => queryPage(context, route));
//   } catch (err) { print(err); }
// }
