// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';

part 'new_pet.g.dart';

@JsonSerializable()
class NewPet {
  const NewPet({
    required this.name,
    this.tag,
  });
  
  factory NewPet.fromJson(Map<String, Object?> json) => _$NewPetFromJson(json);
  
  final String name;
  final String? tag;

  Map<String, Object?> toJson() => _$NewPetToJson(this);
}
