import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:times/pages/team_detail_page.dart';

import '../models/team.dart';
import '../repositories/team_repository.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({Key? key}) : super(key: key);

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  late List<Team> data;
  late TeamRepository teams;

  viewDetails(Team team) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => TeamDetailPage(team: team)
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    teams = context.watch<TeamRepository>();
    data = teams.data;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Times')
        ),
        body: RefreshIndicator(
          onRefresh: () => teams.findTeams(),
          child: ListView.separated(
            itemBuilder: (BuildContext context, int team) {
              return ListTile(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                  leading: SizedBox(width: 40, child: Image.network(data[team].flag)),
                  title: Row(
                    children: [
                      Text(
                          data[team].name,
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500
                          )
                      ),
                    ],
                  ),
                  selectedTileColor: Colors.indigo[50],
                  onTap: () => viewDetails(data[team])
              );
            },
            padding: const EdgeInsets.all(16),
            separatorBuilder: (_,__) => const Divider(),
            itemCount: data.length,
          ),
        ),
    );
  }
}
