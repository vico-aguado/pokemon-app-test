import 'package:hive/hive.dart';
import 'package:orbi_test/src/data/source/local/models/pokemon_stats.dart';

@HiveType(typeId: 1)
class PokemonHiveModel extends HiveObject {
  static const String boxKey = 'pokemon';

  @HiveField(0)
  late String number;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late List<String> types;

  @HiveField(3)
  late String height;

  @HiveField(4)
  late String weight;

  @HiveField(5)
  late PokemonStatsHiveModel stats;

  @HiveField(6)
  late double baseExp;
}
