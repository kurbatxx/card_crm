import 'package:freezed_annotation/freezed_annotation.dart';

part 'init_search.freezed.dart';
part 'init_search.g.dart';

@freezed
class InitSearch with _$InitSearch {
  //@JsonSerializable(explicitToJson: true)
  const factory InitSearch({
    required String search,
    @JsonKey(name: 'org_id') required int schoolId,
    @JsonKey(name: 'show_deleted') required bool showDeleted,
  }) = _InitSearch;

  factory InitSearch.fromJson(Map<String, dynamic> json) =>
      _$InitSearchFromJson(json);
}
