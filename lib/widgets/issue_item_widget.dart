import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:github_app/screens/issue_screen.dart';
import 'package:github_app/utils/colors_constants.dart';
import 'package:github_app/utils/size_responsive_helper.dart';

class IssueItemWidget extends StatelessWidget {
  final info;
  IssueItemWidget({this.info});

  @override
  Widget build(BuildContext context) {
    String avatarUrl = info["user"] != null ? info["user"]["avatar_url"] : "";
    String title = info["title"];
    String strDateTime = info["updated_at"];
    DateTime dateTime = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(strDateTime);
    String strUpdateTime = DateFormat("dd MMM yyyy").format(dateTime);
    String issueState = info["state"];
    String id = info["node_id"].toString();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Material(
        color: kColorPrimary.withOpacity(0.8),
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          splashFactory: InkRipple.splashFactory,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return IssueScreen(info: info);
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
                          color: Colors.white,
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
                            Icons.report_problem_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: 3),
                          Text(
                            "Issue Title",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 4),
                      Padding(
                        padding: EdgeInsets.only(left: 23),
                        child: Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.date_range_rounded,
                            color: Colors.white,
                            size: 14,
                          ),
                          SizedBox(width: 3),
                          Text(
                            strUpdateTime,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
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
                  child: Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: Colors.white,
                        size: 12,
                      ),
                      SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          issueState,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
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
