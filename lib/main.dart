import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orbi_test/src/app.dart';
import 'package:orbi_test/src/data/source/local/local_source.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  await LocalDataSource.initialize();

  runApp(const PokeApp());
}
