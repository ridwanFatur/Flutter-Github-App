import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:github_app/utils/colors_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class IssueScreen extends StatefulWidget {
  final info;
  IssueScreen({this.info});
  @override
  State<IssueScreen> createState() => IssueScreenState();
}

class IssueScreenState extends State<IssueScreen> {
  @override
  Widget build(BuildContext context) {
    String avatarUrl =
        widget.info["user"] != null ? widget.info["user"]["avatar_url"] : "";
    String title = widget.info["title"];
    String strDateTime = widget.info["updated_at"];
    DateTime dateTime = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(strDateTime);
    String strUpdateTime = DateFormat("dd MMM yyyy").format(dateTime);
    String issueState = widget.info["state"];
    String id = widget.info["node_id"].toString();

    return Scaffold(
      backgroundColor: kColorPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(height: 20),
              Hero(
                tag: id,
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(
                    avatarUrl,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Update Date : $strUpdateTime",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Status : $issueState",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  String url = widget.info["html_url"];
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: kColorPrimary.withOpacity(0.3),
                ),
                child: Text(
                  "Go to Github",
                  style: TextStyle(
                    color: kColorPrimary,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
