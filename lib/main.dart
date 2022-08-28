import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:times/repositories/team_repository.dart';

import 'pages/my_app.dart';

void main() async {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (context) => TeamRepository()
          ),
        ],
        child: const MyApp()
    ),
  );
}
