
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
    double a = viewportDims.height / 100 * this;
    return a;
  }
  /// screen width
  double vw() {
    double a = viewportDims.width / 100 * this;
    return a;
  }
}