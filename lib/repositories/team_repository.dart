import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:http/http.dart' as http;

import '../database/db.dart';
import '../models/team.dart';

class TeamRepository extends ChangeNotifier {
  List<Team> _data = [];
  List<Team> get data => _data;

  TeamRepository() {
    _setupDataTeams();
  }

  _teamsTableIsEmpty() async {
    Database db = await DB.instance.database;
    List results = await db.query('teams');
    return results.isEmpty;
  }

  _setupDataTeams() async {
    if (await _teamsTableIsEmpty()) {
      findTeams();
    }
  }

  _readTableTeams() async {
    Database db = await DB.instance.database;
    List results = await db.query('teams');
    _data = results.map((item) {
      return Team(
          id: item['id'],
          name: item['name'],
          flag: item['flag']
      );
    }).toList();
    notifyListeners();
  }

  findTeams() async {
    String baseUrl = 'http://controle.mdvsistemas.com.br';
    String uri = '$baseUrl/Esportes/Times/GetTime';
    final response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List<dynamic> teams = json;
      Database db = await DB.instance.database;
      db.delete('teams');
      Batch batch = db.batch();

      teams.forEach((team) {
        batch.insert('teams', {
          'id': team['Tim_Codigo'],
          'name': team['Tim_Nome'],
          'flag': baseUrl + team['Tim_Bandeira'].toString().substring(1, team['Tim_Bandeira'].toString().length)
        });
      });
      await batch.commit(noResult: true);
    }
    await _readTableTeams();
  }
}