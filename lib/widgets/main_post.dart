
import 'package:flutter/material.dart';
import '../methods/calc.dart';

// logic
// import '../logic/router.dart';

// well.. main..
import '../main.dart';

// widgets
import 'post_elements.dart';



class Post extends StatelessWidget {
  final PostData data;
  Post(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {


          if ( data.viewing ) {
            // closeRoute(context, data);
          } else {
            data.viewing = true;

            // Navigator.of(context).push(
            Navigator.pushNamed( context, '/post', arguments: data );
            // );
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
                      width: data.viewing ? 8.vw() : 0,
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


            //   Hero(
            //     tag: 'hero-image_${data.id}',
            //     child: FadeInImage.assetNetwork(
            //     // height: data.images[0]['source']['height'].toDouble() / (data.images[0]['source']['width'] / postWidth.vw()),
            //     placeholder: 'ass/detail/loading_image.png',
            //     image: data.images[0]['source']['url'],
            //   ),
            // ),

            if ( data.images[0]['source']['url'] != '' ) ...[

              Hero(
                tag: 'hero-image_${data.id}',
                child: Container(
                    constraints: BoxConstraints(
                      minHeight: data.imageLoaded ? 0 : data.images[0]['source']['height'].toDouble() / (data.images[0]['source']['width'] / 92.vw()),
                      minWidth: data.imageLoaded ? 0 : 92.vw(),
                    ),


                    child: Image.network(
                      data.images[0]['source']['url'],
                      // fit: BoxFit.cover,
                      loadingBuilder: (BuildContext context,
                        child,
                    ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) {
                        data.imageLoaded = true;
                        return child;
                      }
                    return Center(

                      child: CircularProgressIndicator(
                        strokeWidth: 20,
                        semanticsLabel: 'Loading Image',
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.orange[700]),
                        value: loadingProgress.expectedTotalBytes != null ?
                        loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                        : null,

                        ),
                      );
                    }
                  ),
                ),
              ),
            ],

            Container(
              constraints: BoxConstraints(
                maxHeight: data.viewing ? double.infinity : 0,
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