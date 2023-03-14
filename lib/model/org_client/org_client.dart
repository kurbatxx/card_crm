import 'package:freezed_annotation/freezed_annotation.dart';

part 'org_client.freezed.dart';
part 'org_client.g.dart';

@freezed
class OrgClient with _$OrgClient {
  //@JsonSerializable(explicitToJson: true)
  const factory OrgClient({
    required String id,
    required String name,
    required String group,
    required String org,
    required String balance,
  }) = _OrgClient;

  factory OrgClient.fromJson(Map<String, dynamic> json) =>
      _$OrgClientFromJson(json);
}
