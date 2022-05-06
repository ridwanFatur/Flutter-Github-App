import 'package:flutter/material.dart';

class ErrorStateWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onPressed;

  ErrorStateWidget({required this.errorMessage, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              onPressed();
            },
            child: Text("Reload"),
          ),
          SizedBox(height: 10),
          Text(errorMessage),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
