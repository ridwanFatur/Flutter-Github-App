import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:github_app/screens/repo_screen.dart';
import 'package:github_app/utils/colors_constants.dart';
import 'package:github_app/utils/size_responsive_helper.dart';

class RepositoryItemWidget extends StatelessWidget {
  final info;
  RepositoryItemWidget({this.info});

  @override
  Widget build(BuildContext context) {
    String avatarUrl = info["owner"] != null ? info["owner"]["avatar_url"] : "";
    String name = info["name"];
    String strDateTime = info["created_at"];
    DateTime dateTime = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(strDateTime);
    String strCreatedTime = DateFormat("dd MMM yyyy").format(dateTime);

    int totalWatchers = info["watchers_count"];
    int totalStars = info["stargazers_count"];
    int totalForks = info["forks_count"];
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
              return RepoScreen(info: info);
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
                            Icons.folder,
                            color: kColorPrimary,
                            size: 20,
                          ),
                          SizedBox(width: 3),
                          Text(
                            "Repo Title",
                            style: TextStyle(
                              fontSize: 14,
                              color: kColorPrimary,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 4),
                      Padding(
                        padding: EdgeInsets.only(left: 23),
                        child: Text(
                          name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.date_range_rounded,
                            color: kColorPrimary,
                            size: 14,
                          ),
                          SizedBox(width: 3),
                          Text(
                            strCreatedTime,
                            style: TextStyle(
                              fontSize: 14,
                              color: kColorPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 20),
                SizedBox(
                  width: 50,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.visibility,
                            color: kColorPrimary,
                            size: 12,
                          ),
                          SizedBox(width: 3),
                          Expanded(
                            child: Text(
                              "$totalWatchers",
                              style: TextStyle(
                                fontSize: 13,
                                color: kColorPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: kColorPrimary,
                            size: 12,
                          ),
                          SizedBox(width: 3),
                          Expanded(
                            child: Text(
                              "$totalStars",
                              style: TextStyle(
                                fontSize: 13,
                                color: kColorPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.info,
                            color: kColorPrimary,
                            size: 12,
                          ),
                          SizedBox(width: 3),
                          Expanded(
                            child: Text(
                              "$totalForks",
                              style: TextStyle(
                                fontSize: 13,
                                color: kColorPrimary,
                              ),
                            ),
                          ),
                        ],
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
