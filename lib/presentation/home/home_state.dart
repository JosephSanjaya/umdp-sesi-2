import 'package:freezed_annotation/freezed_annotation.dart';

import '../../entities/cat_data.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<CatData> catFacts,
  }) = _HomeState;
}