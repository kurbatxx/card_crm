import 'package:freezed_annotation/freezed_annotation.dart';

part 'organization.freezed.dart';
part 'organization.g.dart';

@freezed
class Organization with _$Organization {
  //@JsonSerializable(explicitToJson: true)
  const factory Organization({
    required int id,
    @JsonKey(name: 'short_name') required String shortName,
    @JsonKey(name: 'full_name') required String fullName,
    required String address,
  }) = _Organization;

  factory Organization.fromJson(Map<String, dynamic> json) =>
      _$OrganizationFromJson(json);
}
