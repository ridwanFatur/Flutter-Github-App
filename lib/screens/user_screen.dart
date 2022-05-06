import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UserScreen extends StatefulWidget {
  final info;
  UserScreen({this.info});
  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    String name = widget.info["login"];
    String avatarUrl = widget.info["avatar_url"];
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
