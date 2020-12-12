import 'package:ask_away/models/AppUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoleCard extends StatefulWidget {
  User user;

  RoleCard(this.user);

  @override
  State<StatefulWidget> createState() => RoleCardState();
}

class RoleCardState extends State<RoleCard> {
  String role;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Text(widget.user.username),
          RadioListTile(
            title: Text("Atendee"),
            value: "atendee",
            groupValue: role,
            onChanged: (String value) {
              setState(() {
                role = value;
              });
            },
          ),
          RadioListTile(
            title: Text("Moderator"),
            value: "moderator",
            groupValue: role,
            onChanged: (String value) {
              setState(() {
                role = value;
              });
            },
          ),
          RadioListTile(
            title: Text("Speaker"),
            value: "speaker",
            groupValue: role,
            onChanged: (String value) {
              setState(() {
                role = value;
              });
            },
          )
        ],
      ),
    );
  }
}
