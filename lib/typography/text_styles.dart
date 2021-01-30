
/// text style definition
import 'package:flutter/material.dart';


/// body
class Typography {

  Text title(String text) {
    return new Text(
      text,
      style: TextStyle(
        fontFamily: 'Advent',
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        letterSpacing: -1.0,
        wordSpacing: -2.0,
        color: Colors.white,
      ),
    );
  }

  Text body(String text) {
    return new Text(
      text,
      style: TextStyle(
        fontFamily: 'RoboSlab',
        fontSize: 22.0,
        fontWeight: FontWeight.normal,
        letterSpacing: 1.0,
      ),
    );
  }

  Text comment(String text) {
    return new Text(
      text,
      style: TextStyle(
        fontFamily: 'RoboSlab',
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        letterSpacing: 0.4,
        color: Colors.white,
      ),
    );
  }

  Text tiny( String text, [ TextStyle style ] ) {
    return new Text(
      text,
      style: style ?? TextStyle(
        fontFamily: 'EncSans',
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.4,
        color: Colors.white,
      ),
    );
  }
}

Typography textStyle = new Typography();