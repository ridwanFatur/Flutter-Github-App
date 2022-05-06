import 'package:flutter/material.dart';
import 'package:github_app/utils/colors_constants.dart';

class SearchTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Function onChanged;
  SearchTextField({
    required this.controller,
    this.hintText = "Placeholder",
    required this.onChanged,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  bool isFocus = false;

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Focus(
        onFocusChange: (focus) {
          setState(() {
            isFocus = focus;
          });
        },
        child: TextField(
          controller: widget.controller,
          textInputAction: TextInputAction.done,
          style: TextStyle(
            fontSize: 14,
          ),
          onChanged: (value){
            widget.onChanged(value);
          },
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            focusedBorder: kOutlineInputBorder,
            enabledBorder: kOutlineInputBorderEnabled,
            fillColor: Colors.grey.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(
              Icons.search,
              color: isFocus ? kColorPrimary : kColorPrimary.withOpacity(0.5),
            ),
            contentPadding:
                EdgeInsets.only(right: 0, left: 0, top: 4, bottom: 4),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder kOutlineInputBorderEnabled = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(width: 2, color: kColorPrimary.withOpacity(0.5)),
  );

  OutlineInputBorder kOutlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(width: 2, color: kColorPrimary),
  );
}
