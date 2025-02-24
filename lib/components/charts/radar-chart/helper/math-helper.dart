import 'dart:math' as math;

class ChartMathHelper {
  // get the minimum from a list
  // some of the items are allowed to be null
  static getMin(List<double> list) {
    return _getMinOrMax(list, 1);
  }

  // get the maximum from a list
  // some of the items are allowed to be null
  static getMax(List<double> list) {
    return _getMinOrMax(list, 2);
  }

  // get the minimum or maximum from a list
  // type == 1: get the minimum
  // type == 2: get the maximum
  // some of the items are allowed to be null
  static _getMinOrMax(List<double> list, int type) {
    double value;
    for (int i=0; i<list.length; i++) {
      if (list[i] != null) {
        value = list[i];
        break;
      }
    }
    if (value == null) return null;
    for (int i=0; i<list.length; i++) {
      if (list[i] != null) {
        if (type == 1) value = math.min(value, list[i]);
        if (type == 2) value = math.max(value, list[i]);
      }
    }
    return value;
  }
}