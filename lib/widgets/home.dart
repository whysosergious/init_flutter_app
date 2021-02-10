
import 'package:flutter/material.dart';
import '../typography/text_styles.dart';
import '../logic/fetch.dart';




class Home extends StatefulWidget {
  @override
  HomeState createState() {
    return HomeState();
  }
}


class HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // AnimationController animatedController;
  // Animation step1, step2, step3;

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    // animatedController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String inputText = '';
    // bool buttonDisabled = false;
    // bool introDone = false;

    FocusScopeNode currentFocus = FocusScope.of(context);

    return GestureDetector(
      onTap: () {
        currentFocus.unfocus();
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              SizedBox(height: 70),
              Text( 'Hey there!',
                style: textStyle.stats.custom(color: Colors.white, fontSize: 27),
              ),
              Container(
                height: 40,
                width: 200,
                padding: EdgeInsets.only(left: 7, right: 7),
                margin: EdgeInsets.only(top: 60, bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius:  BorderRadius.circular(10.0),
                ),
                child: Align(
                  child: TextField(
                    // autofocus: introDone || true,
                    style: TextStyle(
                      // height: 2,
                    ),
                    decoration: InputDecoration.collapsed(
                      hintText: 'Enter a subreddit',
                    ),
                    onEditingComplete: () {

                    },
                    onChanged: (value) {
                      inputText = value;
                      // buttonDisabled = value == '' && true;
                    },
                    onSubmitted: (value) {
                      currentFocus.unfocus();
                      subreddit = inputText;
                      posts.fetchData( context, '/pages' );
                    },
                  ),
                ),
              ),
              
              Container(
                height: 45,
                width: 200,
                child: RaisedButton(
                  // color: buttonDisabled ? Colors.orange[600].withAlpha(125) : Colors.orange[900],
                  color: Colors.orange[900],
                  child: Text('Browse', style: textStyle.stats.custom(color: Colors.white, fontSize: 20) ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    // side: BorderSide(color: Colors.red)
                  ),
                  onPressed: () {
                    currentFocus.unfocus();
                    subreddit = inputText;
                    posts.fetchData( context, '/pages' );
                  }
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 70, bottom: 20),
                child: Text( 'Or choose one below',
                  style: textStyle.stats.custom(color: Colors.brown[100]),
                ),
              ),
              Column(
                children: <Widget>[
                  presetSubreddit('doggos', context),
                  // SizedBox(height: 4),  // _MARGIN_
                  presetSubreddit('Funny', context),
                  // SizedBox(height: 4),  // _MARGIN_
                  presetSubreddit('Unexpected', context),
                  // SizedBox(height: 4),  // _MARGIN_
                  presetSubreddit('cats', context),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


/// Preset subreddits
Widget presetSubreddit(String name, BuildContext context) => FlatButton(         
  height: 0,    
  child: Text( 'r/$name',
    style: textStyle.details.custom(color: Colors.blue),
  ),
    onPressed: () {
    subreddit = name;
    posts.fetchData( context, '/pages' );
  },
);