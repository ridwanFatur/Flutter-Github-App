class HelperMath {
  static double absVal(val) {
    return val < 0 ? -val : val;
  }

  static double getCenterVal(val, double extendedSize) {
    val = val + extendedSize;
    return val < 0 ? -val : val;
  }
}
