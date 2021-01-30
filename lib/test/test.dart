import 'package:flutter/material.dart';


class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Center(
          child:
            Text(
              'This is more suitable for body text.',
              style: TextStyle(
                fontFamily: 'EncSans',
                fontSize: 18.0,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.7,
              ),
            ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text('Click'),
        backgroundColor: Colors.purple[900],
      ),
    );
  }
}





class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        Center(
          child: ListView(
            children: [
              Image.network('https://i.pinimg.com/originals/51/0d/a9/510da98abbe03f7ff9a7ce6eb0f362e7.jpg'),
              Image.network('https://i.pinimg.com/originals/51/0d/a9/510da98abbe03f7ff9a7ce6eb0f362e7.jpg'),
              Image.network('https://i.pinimg.com/originals/51/0d/a9/510da98abbe03f7ff9a7ce6eb0f362e7.jpg'),
              Image.network('https://i.pinimg.com/originals/51/0d/a9/510da98abbe03f7ff9a7ce6eb0f362e7.jpg'),
              Image.network('https://i.pinimg.com/originals/51/0d/a9/510da98abbe03f7ff9a7ce6eb0f362e7.jpg'),
              Image.network('https://i.pinimg.com/originals/51/0d/a9/510da98abbe03f7ff9a7ce6eb0f362e7.jpg'),
            ],
          ),

        ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[900],
        onPressed: () {},

child: Image(image:
  AssetImage('ass/icons/pages.png'),
  width: 37.0,

  ),
        ),



    );
  }
}