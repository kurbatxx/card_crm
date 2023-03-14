import 'package:freezed_annotation/freezed_annotation.dart';

part 'init_search.freezed.dart';
part 'init_search.g.dart';

@freezed
class InitSearch with _$InitSearch {
  //@JsonSerializable(explicitToJson: true)
  const factory InitSearch({
    required String search,
    @JsonKey(name: 'school_id') required int schoolId,
    @JsonKey(name: 'deleted') required bool deleted,
  }) = _InitSearch;

  factory InitSearch.fromJson(Map<String, dynamic> json) =>
      _$InitSearchFromJson(json);
}
