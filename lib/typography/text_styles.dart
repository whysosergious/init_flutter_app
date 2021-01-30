
/// Everything typography
import 'package:flutter/material.dart';



/// I like shorter definitions .. this class gives us a shorter syntax when defining text style
class ThemeTextStyle {
    TextStyle title = TextStyle(fontFamily: 'RoboSlab', fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white); // [ titles and headings ]
    TextStyle details = TextStyle(fontFamily: 'RoboSlab', fontSize: 13.0, color: Colors.brown[300]); // [ details (users, timestamps) ]
    TextStyle stats = TextStyle(fontFamily: 'Montserrat', fontSize: 14.0, fontWeight: FontWeight.w400, color: Colors.brown[200]); // [ stats (comment counts, ratings) ]
    TextStyle body = TextStyle(fontFamily: 'RoboSlab', fontSize: 16.0); // [ body (selftext) ]
    TextStyle bodySmall = TextStyle(fontFamily: 'RoboSlab', fontSize: 14.0); // [ small body text (comments) ]
}
ThemeTextStyle textStyle; // globally scoped variable


/// I think I'm allright at naming things, right?
ThemeData mainTheme() {

  textStyle = new ThemeTextStyle(); // instance here for hot reaload

  return ThemeData(
    // default brightness and colors.
    brightness: Brightness.dark,
    // primaryColor: Colors.lightBlue[800],
    // accentColor: Colors.cyan[600],

    // default font family
    fontFamily: 'RoboSlab',

    // apply text styles to theme
    textTheme: TextTheme(
      headline1: textStyle.title,
      headline2: textStyle.details,
      headline3: textStyle.stats,
      bodyText1: textStyle.body,
      bodyText2: textStyle.bodySmall,
    ),
  );
}


/// return targeted TextStyle with individually modified properties
extension ModifyTextStyleProperties on TextStyle {

  TextStyle custom({

    bool inherit,
    Color color,
    Color backgroundColor,
    String fontFamily,
    List<String> fontFamilyFallback,
    double fontSize,
    FontWeight fontWeight,
    FontStyle fontStyle,
    double letterSpacing,
    double wordSpacing,
    TextBaseline textBaseline,
    double height,
    Locale locale,
    Paint foreground,
    Paint background,
    // List<ui.Shadow> shadows,                               *** Fix this before animating
    // List<ui.FontFeature> fontFeatures,
    TextDecoration decoration,
    Color decorationColor,
    TextDecorationStyle decorationStyle,
    double decorationThickness,

  }) {

    return TextStyle(
      inherit: inherit ?? this.inherit,
      color: this.foreground == null && foreground == null ? color ?? this.color : null,
      backgroundColor: this.background == null && background == null ? backgroundColor ?? this.backgroundColor : null,
      fontFamily: fontFamily ?? this.fontFamily,
      fontFamilyFallback: fontFamilyFallback ?? this.fontFamilyFallback,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? this.fontStyle,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
      textBaseline: textBaseline ?? this.textBaseline,
      height: height ?? this.height,
      locale: locale ?? this.locale,
      foreground: foreground ?? this.foreground,
      background: background ?? this.background,
      // shadows: shadows ?? this.shadows,                            *** Fix this before animating
      // fontFeatures: fontFeatures ?? this.fontFeatures,
      decoration: decoration ?? this.decoration,
      decorationColor: decorationColor ?? this.decorationColor,
      decorationStyle: decorationStyle ?? this.decorationStyle,
      decorationThickness: decorationThickness ?? this.decorationThickness,
    );
  }
}


