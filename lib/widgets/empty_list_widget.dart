import 'package:flutter/material.dart';
import 'package:github_app/utils/assets_constants.dart';

class EmptyListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kIconNoFoundResult,
              width: 100,
              height: 100,
            ),
            SizedBox(height: 10),
            Text("No Result to show"),
          ],
        ),
      ),
    );
  }
}
