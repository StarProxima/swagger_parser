// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_pet.freezed.dart';
part 'new_pet.g.dart';

@Freezed()
class NewPet with _$NewPet {
  const factory NewPet({
    required String name,
    String? tag,
  }) = _NewPet;
  
  factory NewPet.fromJson(Map<String, Object?> json) => _$NewPetFromJson(json);
}
