import 'dart:convert';
import 'package:orbi_test/src/domain/entities/flavor_model.dart';
import 'package:orbi_test/src/domain/entities/general_model.dart';
import 'package:orbi_test/src/domain/entities/genus_model.dart';
import 'package:orbi_test/src/domain/entities/name_model.dart';
import 'package:orbi_test/src/domain/entities/pal_park_model.dart';
import 'package:orbi_test/src/domain/entities/variety_model.dart';

class Species {
  Species({
    this.baseHappiness,
    this.captureRate,
    this.color,
    this.eggGroups,
    this.evolutionChain,
    this.evolvesFromSpecies,
    this.flavorTextEntries,
    this.formsSwitchable,
    this.genderRate,
    this.genera,
    this.growthRate,
    this.habitat,
    this.hasGenderDifferences,
    this.hatchCounter,
    this.id,
    this.isBaby,
    this.isLegendary,
    this.isMythical,
    this.name,
    this.names,
    this.order,
    this.palParkEncounters,
    this.shape,
    this.varieties,
  });

  factory Species.fromMap(Map<String, dynamic> map) {
    return Species(
      baseHappiness:
          map['base_happiness'] != null ? map['base_happiness'] as int : null,
      captureRate:
          map['capture_rate'] != null ? map['capture_rate'] as int : null,
      color: map['color'] != null
          ? GeneralData.fromMap(
              map['color'] as Map<String, dynamic>,
            )
          : null,
      eggGroups: map['egg_groups'] != null
          ? List<GeneralData>.from(
              (map['egg_groups'] as List<dynamic>).map<GeneralData?>(
                (x) => GeneralData.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      evolutionChain: map['evolution_chain'] != null
          ? GeneralData.fromMap(map['evolution_chain'] as Map<String, dynamic>)
          : null,
      evolvesFromSpecies: map['evolves_from_species'] as dynamic,
      flavorTextEntries: map['flavor_text_entries'] != null
          ? List<FlavorTextEntry>.from(
              (map['flavor_text_entries'] as List<dynamic>)
                  .map<FlavorTextEntry?>(
                (x) => FlavorTextEntry.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      formsSwitchable: map['forms_switchable'] != null
          ? map['forms_switchable'] as bool
          : null,
      genderRate: map['gender_rate'] != null ? map['gender_rate'] as int : null,
      genera: map['genera'] != null
          ? List<Genus>.from(
              (map['genera'] as List<dynamic>).map<Genus?>(
                (x) => Genus.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      growthRate: map['growth_rate'] != null
          ? GeneralData.fromMap(map['growth_rate'] as Map<String, dynamic>)
          : null,
      habitat: map['habitat'] != null
          ? GeneralData.fromMap(
              map['habitat'] as Map<String, dynamic>,
            )
          : null,
      hasGenderDifferences: map['has_gender_differences'] != null
          ? map['has_gender_differences'] as bool
          : null,
      hatchCounter:
          map['hatch_counter'] != null ? map['hatch_counter'] as int : null,
      id: map['id'] != null ? map['id'] as int : null,
      isBaby: map['is_baby'] != null ? map['is_baby'] as bool : null,
      isLegendary:
          map['is_legendary'] != null ? map['is_legendary'] as bool : null,
      isMythical:
          map['is_mythical'] != null ? map['is_mythical'] as bool : null,
      name: map['name'] != null ? map['name'] as String : null,
      names: map['names'] != null
          ? List<Name>.from(
              (map['names'] as List<dynamic>).map<Name?>(
                (x) => Name.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      order: map['order'] != null ? map['order'] as int : null,
      palParkEncounters: map['pal_park_encounters'] != null
          ? List<PalParkEncounter>.from(
              (map['pal_park_encounters'] as List<dynamic>)
                  .map<PalParkEncounter?>(
                (x) => PalParkEncounter.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      shape: map['shape'] != null
          ? GeneralData.fromMap(
              map['shape'] as Map<String, dynamic>,
            )
          : null,
      varieties: map['varieties'] != null
          ? List<Variety>.from(
              (map['varieties'] as List<dynamic>).map<Variety?>(
                (x) => Variety.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  factory Species.fromJson(String source) =>
      Species.fromMap(json.decode(source) as Map<String, dynamic>);
  final int? baseHappiness;
  final int? captureRate;
  final GeneralData? color;
  final List<GeneralData>? eggGroups;
  final GeneralData? evolutionChain;
  final dynamic evolvesFromSpecies;
  final List<FlavorTextEntry>? flavorTextEntries;
  final bool? formsSwitchable;
  final int? genderRate;
  final List<Genus>? genera;
  final GeneralData? growthRate;
  final GeneralData? habitat;
  final bool? hasGenderDifferences;
  final int? hatchCounter;
  final int? id;
  final bool? isBaby;
  final bool? isLegendary;
  final bool? isMythical;
  final String? name;
  final List<Name>? names;
  final int? order;
  final List<PalParkEncounter>? palParkEncounters;
  final GeneralData? shape;
  final List<Variety>? varieties;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'baseHappiness': baseHappiness,
      'captureRate': captureRate,
      'color': color,
      'eggGroups': eggGroups?.map((x) => x).toList(),
      'evolutionChain': evolutionChain?.toMap(),
      'evolvesFromSpecies': evolvesFromSpecies,
      'flavorTextEntries': flavorTextEntries?.map((x) => x.toMap()).toList(),
      'formsSwitchable': formsSwitchable,
      'genderRate': genderRate,
      'genera': genera?.map((x) => x.toMap()).toList(),
      'growthRate': growthRate,
      'habitat': habitat,
      'hasGenderDifferences': hasGenderDifferences,
      'hatchCounter': hatchCounter,
      'id': id,
      'isBaby': isBaby,
      'isLegendary': isLegendary,
      'isMythical': isMythical,
      'name': name,
      'names': names?.map((x) => x.toMap()).toList(),
      'order': order,
      'palParkEncounters': palParkEncounters?.map((x) => x.toMap()).toList(),
      'shape': shape,
      'varieties': varieties?.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
}
