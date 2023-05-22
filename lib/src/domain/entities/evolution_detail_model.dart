// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:orbi_test/src/domain/entities/general_model.dart';

class EvolutionDetail extends Equatable {
  final int? minLevel;
  final bool? needsOverworldRain;
  final String? timeOfDay;
  final GeneralData? trigger;
  final bool? turnUpsideDown;

  const EvolutionDetail({
    this.minLevel,
    this.needsOverworldRain,
    this.timeOfDay,
    this.trigger,
    this.turnUpsideDown,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'minLevel': minLevel,
      'needsOverworldRain': needsOverworldRain,
      'timeOfDay': timeOfDay,
      'trigger': trigger?.toMap(),
      'turnUpsideDown': turnUpsideDown,
    };
  }

  factory EvolutionDetail.fromMap(Map<String, dynamic> map) {
    return EvolutionDetail(
      minLevel: map['min_level'] != null ? map['min_level'] as int : null,
      needsOverworldRain: map['needs_overworld_rain'] != null
          ? map['needs_overworld_rain'] as bool
          : null,
      timeOfDay:
          map['time_of_day'] != null ? map['time_of_day'] as String : null,
      trigger: map['trigger'] != null
          ? GeneralData.fromMap(map['trigger'] as Map<String, dynamic>)
          : null,
      turnUpsideDown: map['turn_upside_down'] != null
          ? map['turn_upside_down'] as bool
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EvolutionDetail.fromJson(String source) =>
      EvolutionDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object?> get props {
    return [
      minLevel,
      needsOverworldRain,
      timeOfDay,
      trigger,
      turnUpsideDown,
    ];
  }
}
