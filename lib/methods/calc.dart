
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