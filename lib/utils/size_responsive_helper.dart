import 'package:flutter/material.dart';

class Responsive {
  static double textSearchHeight(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 480) {
      return 70;
    } else if (width < 600) {
      return 90;
    } else {
      return 100;
    }
  }

  static double optionsSectionHeight(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 480) {
      return 120;
    } else if (width < 600) {
      return 140;
    } else {
      return 150;
    }
  }

  static double splashScreenLogo(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 480) {
      return 250;
    } else if (width < 600) {
      return 270;
    } else {
      return 280;
    }
  }

  static double paddingBottomContentData(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 480) {
      return 70;
    } else if (width < 600) {
      return 80;
    } else {
      return 90;
    }
  }

  static double avatarSizePicture(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 480) {
      return 70;
    } else if (width < 600) {
      return 80;
    } else {
      return 90;
    }
  }

  static double searchTypeCircleSize(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 480) {
      return 25;
    } else if (width < 600) {
      return 35;
    } else {
      return 45;
    }
  }

  static double heightCentralSize(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 480) {
      return 130;
    } else if (width < 600) {
      return 140;
    } else {
      return 150;
    }
  }
}
