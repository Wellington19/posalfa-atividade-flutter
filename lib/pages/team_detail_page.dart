import 'package:flutter/material.dart';

import '../models/team.dart';

class TeamDetailPage extends StatefulWidget {
  Team team;

  TeamDetailPage({Key? key, required this.team}) : super(key: key);

  @override
  _TeamDetailPageState createState() => _TeamDetailPageState();
}

class _TeamDetailPageState extends State<TeamDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.team.name),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 200, child: Image.network(widget.team.flag)),
                    Container(width: 10)
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 24)
              )
            ],
          ),
        )
    );
  }
}
