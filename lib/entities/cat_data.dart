import 'package:freezed_annotation/freezed_annotation.dart';

part 'cat_data.freezed.dart';
part 'cat_data.g.dart';

@freezed
class CatData with _$CatData {
  const factory CatData({
    required List<String> data,
  }) = _CatData;

  factory CatData.fromJson(Map<String, dynamic> json) => _$CatDataFromJson(json);
}