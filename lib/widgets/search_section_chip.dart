import 'package:flutter/material.dart';
import 'package:github_app/utils/colors_constants.dart';
import 'package:github_app/utils/size_responsive_helper.dart';

class SearchSectionChip extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isActive;
  final String title;
  SearchSectionChip({
    required this.onPressed,
    required this.isActive,
    required this.title,
  });

  @override
  State<SearchSectionChip> createState() => _SearchSectionChipState();
}

class _SearchSectionChipState extends State<SearchSectionChip> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        splashFactory: InkRipple.splashFactory,
        onTap: () {
          widget.onPressed();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: Responsive.searchTypeCircleSize(context)),
              AnimatedContainer(
                width: widget.isActive
                    ? Responsive.searchTypeCircleSize(context)
                    : 18.0,
                height: widget.isActive
                    ? Responsive.searchTypeCircleSize(context)
                    : 18.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.isActive ? kColorPrimary : Colors.white,
                  border: Border.all(
                    color: kColorPrimary,
                    width: 3,
                  ),
                ),
                duration: Duration(milliseconds: 200),
              ),
              SizedBox(width: 10),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
