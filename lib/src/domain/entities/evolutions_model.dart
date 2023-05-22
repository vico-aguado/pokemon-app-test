import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:orbi_test/src/domain/entities/chain_model.dart';

class Evolutions extends Equatable {
  const Evolutions({
    this.chain,
    this.id,
  });

  factory Evolutions.fromMap(Map<String, dynamic> map) {
    return Evolutions(
      chain: map['chain'] != null
          ? Chain.fromMap(map['chain'] as Map<String, dynamic>)
          : null,
      id: map['id'] != null ? map['id'] as int : null,
    );
  }

  factory Evolutions.fromJson(String source) =>
      Evolutions.fromMap(json.decode(source) as Map<String, dynamic>);
  final Chain? chain;
  final int? id;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chain': chain?.toMap(),
      'id': id,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [chain, id];
}
