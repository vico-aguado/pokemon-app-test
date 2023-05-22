import 'package:hive/hive.dart';
import 'package:orbi_test/src/data/source/local/models/pokemon.dart';
import 'package:orbi_test/src/data/source/local/models/pokemon_stats.dart';

class PokemonHiveModelAdapter extends TypeAdapter<PokemonHiveModel> {
  @override
  final int typeId = 1;

  @override
  PokemonHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonHiveModel()
      ..number = fields[0] as String
      ..name = fields[1] as String
      ..types = (fields[2] as List).cast<String>()
      ..height = fields[3] as String
      ..weight = fields[4] as String
      ..baseExp = fields[5] as double
      ..stats = fields[6] as PokemonStatsHiveModel;
  }

  @override
  void write(BinaryWriter writer, PokemonHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.types)
      ..writeByte(3)
      ..write(obj.height)
      ..writeByte(4)
      ..write(obj.weight)
      ..writeByte(5)
      ..write(obj.baseExp)
      ..writeByte(6)
      ..write(obj.stats);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
