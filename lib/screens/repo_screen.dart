import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class RepoScreen extends StatefulWidget {
  final info;
  RepoScreen({this.info});
  @override
  State<RepoScreen> createState() => RepoScreenState();
}

class RepoScreenState extends State<RepoScreen> {
  @override
  Widget build(BuildContext context) {
    String avatarUrl =
        widget.info["owner"] != null ? widget.info["owner"]["avatar_url"] : "";
    String name = widget.info["name"];
    String strDateTime = widget.info["created_at"];
    DateTime dateTime = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(strDateTime);
    String strCreatedTime = DateFormat("dd MMM yyyy").format(dateTime);

    int totalWatchers = widget.info["watchers_count"];
    int totalStars = widget.info["stargazers_count"];
    int totalForks = widget.info["forks_count"];
    String id = widget.info["node_id"].toString();

    return Scaffold(
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
                name,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Created Date : $strCreatedTime",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Total Watchers : $totalWatchers",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
              Text(
                "Total Stars : $totalStars",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                ),
              ),
              Text(
                "Total Forks : $totalForks",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
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
                child: Text("Go to Github"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
