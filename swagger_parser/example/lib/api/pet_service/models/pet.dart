// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'pet.g.dart';

@JsonSerializable()
class Pet {
  const Pet({
    required this.name,
    this.tag,
    this.id,
  });
  
  factory Pet.fromJson(Map<String, Object?> json) => _$PetFromJson(json);
  
  final String name;
  final String? tag;
  final int? id;

  Map<String, Object?> toJson() => _$PetToJson(this);
}
