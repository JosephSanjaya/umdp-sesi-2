import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'cat_data.freezed.dart';
part 'cat_data.g.dart';

@freezed
class CatData with _$CatData {
  @HiveType(typeId: 0) // Assign a unique type ID for Hive
  const factory CatData({
    @HiveField(0) required List<String> data,
    @HiveField(1) String? imageUrl,
  }) = _CatData;

  factory CatData.fromJson(Map<String, dynamic> json) => _$CatDataFromJson(json);
}
