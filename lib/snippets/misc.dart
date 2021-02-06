    // Hero(

  //   tag: data.id,
  //   flightShuttleBuilder:
  //     (BuildContext flightContext,
  //       Animation<double> animation,
  //       HeroFlightDirection flightDirection,
  //       BuildContext fromHeroContext,
  //     BuildContext toHeroContext,) {

  //       return SingleChildScrollView(
  //         child: fromHeroContext.widget,
  //       );
  //     },
  //   child: Material(
  // child: Column(children: [



// class AnimatedMargin extends StatefulWidget {
//   @override
//   AnimatedMarginState createState() => AnimatedMarginState();
// }

// class AnimatedMarginState extends State<AnimatedMargin> {
//   // double height = 100;
//   final controller = ScrollController();



//   // onScroll() {
//   //   setState(() {
//   //     height = controller.offset / 100;
//   //   });
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: controller,
//       builder: (BuildContext context, Widget child){
//         double height = controller.offset;
//         return Container(
//           height: height,
//           width: 100,
//           color: Colors.green,
//         );
//       },
//     );
//   }
// }


// Timer(Duration(seconds: 3), () {
//   print("Yeah, this line is printed after 3 second");
// });

// Timer.periodic(Duration(seconds: 5), (timer) {
//   print(DateTime.now());
// });


// extension GlobalKeyExtension on GlobalKey {
//   Rect get globalPaintBounds {
//     final renderObject = currentContext?.findRenderObject();
//     var translation = renderObject?.getTransformTo(null)?.getTranslation();
//     if (translation != null && renderObject.paintBounds != null) {
//       return renderObject.paintBounds
//           .shift(Offset(translation.x, translation.y));
//     } else {
//       return null;
//     }
//   }
// }
//           AnimatedBuilder(
//   animation: controller,
//   builder: (BuildContext context, Widget child){
//     double height = 100 + controller.offset;
//         return Container(
//           height: height,//status bar height
//           width: 100,
//           color: Colors.green,
//         );
//   },
// ),


                // animation
                // print(controller.offset);
                // return Transform.scale(
                //   scale: controller.offset / 100,
                //   child: child,
                // );












//                 // yes this is horrible but temporary...
//   bool stateReady = false;
//   void checkData() async {
//     if (postList == null) {
//       Timer(Duration(milliseconds: 100), () {
//         checkData();
//       });
//     } else {
//       setState(() {
//         this.list = postList;
//         sortBoxes( 0 );
//         stateReady = false;
//       });
//       stateReady = await awaitChange();
//       Timer(Duration(milliseconds: 400), () {
//         sortBoxValues( 0 );
//       });

//     }
//   }

//   Future<bool> awaitChange() async {
//     return true;
//   }

//   // Map<String, dynamic> boxTemplate = animatedBox();
//   void sortBoxes( int index ) {
//     boxes['$index'] = { 'a': 'a' };
//     boxes['$index']['boxKey_$index'] = new GlobalKey();
//     boxes['$index']['child'] = ( GlobalKey key ) => animatedBox( req: 'child', gk: key );
//     boxes['$index']['animated_box'] = ( double mod ) => animatedBox( req: 'box', modifier: mod );



//   print(boxes );
//     // Timer(Duration(milliseconds: 200), () {
//       // getRect();
//     // });
//   }

//   void sortBoxValues( int index ) {
//     // GlobalKey k = boxes['$index']['key'];
//     // rect = boxes['$index']['boxKey_$index'].currentContext.findRenderObject();
//     // position = rect.localToGlobal(Offset.zero);
//     // boxes['$index']['rect'] = rect;
//     // boxes['$index']['init_y'] = position.dy.toInt();
//     // initOffsets.add(boxes['$index']['init_y']);

//     stateReady = true;

//     // print((boxes['$index'] as Map));
//   }

//   @override
//   Widget build(BuildContext context) {
//     // print('a');
//     viewingPost = false;
//     return SingleChildScrollView(
//         controller: controller,
//         child: Column(
//         children: [

//           this.list[0],


//           (() {
//             // print('d');
//             int index = 0;
//             // animatedBox( index: index );
//             // boxes = { '$index': { 'key': 'a' }};
//             // print(boxes['0']['child']);
//             // if ( rect != null ) {

//             //   Offset position = rect.localToGlobal(Offset.zero);
//             //   print(position);
//             // }
//             if ( stateReady ) {

//               // print(boxes['0']);
//             return AnimatedBuilder(
//               animation: controller,
//               child: boxes['0']['child']( boxes['$index']['boxKey_$index'] ),



//               builder: (BuildContext context, Widget child) {
//                 if ( rect != null ) {
//                   position = rect.localToGlobal(Offset.zero);
//                   print(position.dy);
//                 }
//                 // print(boxes['0']['child']( boxes['$index']['boxKey_$index'] ).globalKey);
//                 // return Container();
//                 // return boxes['$index']['animated_box']( modifier: controller.offset );
//                 return boxes['$index']['animated_box']( controller.offset );
//               },
//             );
//             } return Container(height: 4, width: 4);
//           })(),





//           /// DRY they said.. well..
// Widget animatedBox({ GlobalKey gk, double modifier, String req }) {

//   /// child element with the global key for offset
//   Widget child ({ GlobalKey key }) => Center(
//       child: Container(
//       key: key,
//       width: 40,
//       height: 40,
//     ),
//   );

//   /// animated container to well .. do what we want
//   Widget animatedBox ({ double mod }) => AnimatedContainer(
//     duration: Duration(milliseconds: 400),
//     curve: Curves.decelerate,
//     height: mod / 4 + 40,
//     width: 50,
//     color: Colors.green,
//     child: child(),
//   );

//   // Map<String, dynamic> result = { 'child': child( key: gk ), 'animated_box': animatedBox( mod: modifier ) };
//   Widget result;
//   if ( req == 'child' ) {
//     result = child( key: gk );
//   } else if ( req == 'box' ) {
//     result = animatedBox( mod: modifier )
//   }

//   return result;
// }



// items: allDestinations.map((Destination destination) {
//           return BottomNavigationBarItem(
//             icon: Icon(destination.icon),
//             backgroundColor: destination.color,
//             title: Text(destination.title)
//           );
//         }).toList(),






    // selectedPageIndex = 0;
    // pages = [
    //   //The individual tabs.
    // ];

    // pageController = PageController(initialPage: selectedPageIndex);

// return Scaffold(
//       body: PageView(
//         controller: pageController,

//       // child: SingleChildScrollView(
//       //   controller: controller,
//       //   child: Column(
//         children: [


//             ...widgets,




//           ],
//         ),
//           // ),
//       // ),
//     );








// height: boxes[index]['visible'] && boxes[index]['pos'].dy > 0 && boxes[index]['pos'].dy < 100.vh() &&
//                   boxes[index]['pos'].dy < 50.vh() ?
//                     10.vh() - boxes[index]['pos'].dy * 0.12 :
//                   boxes[index]['pos'].dy > 50.vh() ?
//                     boxes[index]['pos'].dy * 0.2 - 8.vh(): 10.vh(),





// return AnimatedContainer(
//         duration: Duration(milliseconds: 1500),
//         curve: Curves.decelerate,
//         height: boxes[index]['visible'] && boxes[index]['pos'].dy > 0 && boxes[index]['pos'].dy < 100.vh() &&
//                   boxes[index]['pos'].dy < 100.vh() ?
//                     10.vh() - boxes[index]['pos'].dy * 0.12 :
//                   boxes[index]['pos'].dy > 100.vh() ?
//                     boxes[index]['pos'].dy * 0.2 - 8.vh(): 10.vh(),

//         child: child,
//     );

// animatedController = new AnimationController(
//  duration: Duration(milliseconds: 3000),
//  vsync: this,
// );
//  return Transform.translate(

//       // offset: Offset( 0, boxes[index]['visible'] ? boxes[index]['pos'].dy * 0.5 : -25.vh()),
//       offset: Offset( 0, boxes[index]['visible'] && boxes[index]['pos'].dy > 0 && boxes[index]['pos'].dy < 100.vh() &&
//                   boxes[index]['pos'].dy < 50.vh() ?
//                     10.vh() - boxes[index]['pos'].dy * 0.12 :
//                   boxes[index]['pos'].dy > 50.vh() ?
//                     boxes[index]['pos'].dy * 0.2 - 8.vh(): 10.vh(), ),
//       child: child,
//     );

    // offsetAnimation = Tween(
    //   begin: 0.5,
    //   end: 1.0,
    // ).animate(CurvedAnimation(
    //   parent: animatedController,
    //   curve: Curves.bounceOut
    // ));





// _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     );
//     offsetAnimation = Tween<Offset>(
//       begin: Offset.zero,
//       end: const Offset(0.0, 50),
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.elasticIn,
//     ));



// class DynamicHeader extends SliverPersistentHeaderDelegate {
//   DynamicHeader();
//   @override
//     Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//       return LayoutBuilder(
//           builder: (context, constraints) {
//             // final Color color = Colors.primaries[index];
//             final double percentage = (constraints.maxHeight - minExtent)/(maxExtent - minExtent);

//             // if (++index > Colors.primaries.length-1)
//             //   index = 0;

//             return Container(
//               // decoration: BoxDecoration(
//               //     boxShadow: [BoxShadow(blurRadius: 4.0, color: Colors.black45)],
//               //     gradient: LinearGradient(
//               //         colors: [Colors.blue, color]
//               //     )
//               // ),
//               height: constraints.maxHeight,
//               child: SafeArea(
//                   child: Center(
//                     child: CircularProgressIndicator(
//                       value: percentage,
//                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                     ),
//                   )
//               ),
//             );
//           }
//       );
//     }

//     @override
//     bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;

//     @override
//     double get maxExtent => 250.0;

//     @override
//     double get minExtent => 80.0;
//   }
// }