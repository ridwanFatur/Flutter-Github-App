import 'package:flutter/material.dart';
import 'package:github_app/screens/user_screen.dart';
import 'package:github_app/utils/colors_constants.dart';
import 'package:github_app/utils/size_responsive_helper.dart';

class UserItemWidget extends StatelessWidget {
  final info;
  UserItemWidget({this.info});

  @override
  Widget build(BuildContext context) {
    String name = info["login"];
    String avatarUrl = info["avatar_url"];
    String id = info["node_id"].toString();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Material(
        color: Colors.grey.withOpacity(0.4),
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          splashFactory: InkRipple.splashFactory,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return UserScreen(info: info);
            }));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              children: [
                Material(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(10),
                  child: Hero(
                    tag: id,
                    child: Image.network(
                      avatarUrl,
                      width: Responsive.avatarSizePicture(context),
                      height: Responsive.avatarSizePicture(context),
                      fit: BoxFit.cover,
                      errorBuilder: (context, exception, stackTrace) {
                        return Container(
                          width: Responsive.avatarSizePicture(context),
                          height: Responsive.avatarSizePicture(context),
                          color: kColorPrimary,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.account_circle_sharp,
                            color: kColorPrimary,
                            size: 20,
                          ),
                          SizedBox(width: 3),
                          Text(
                            "Username",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.only(left: 23),
                        child: Text(
                          name,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
