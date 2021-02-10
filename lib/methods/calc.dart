
/// mathematical custom extensions for qualitify of life improvement =P

/// we need the viewport dims we get in our the Body() BuildContext
import '../main.dart';




// double screenWidth = WidgetsBinding.instance.window.physicalSize.width;

/// method that calculating percent of screen dimensions
/// accepts int while returning double
/// /// { 66.vh() : 66% of screen height }
/// { 90.vw() : 90% of screen width }
/// T0D0!***
/// Device Orientation Listener
extension CalculateViewportDims on int {
  /// screen height
  double vh() {
    double result = viewportDims.height / 100 * this;
    return result;
  }
  /// screen width
  double vw() {
    double result = viewportDims.width / 100 * this;
    return result;
  }

  /// calculate AR from image width and return the haight
  double ar() {
    double result = this / viewportDims.height;
    return result;
  }
}

/// lets try to create a really short condition check
extension Conditioner on dynamic {
  /// condition check
  bool cc() {
    if ( this ) {
      return true;
    }
    return false;
  }
}

/// formatting timestamp
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