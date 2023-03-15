import 'package:card_crm/model/org_client/org_client.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'org_clients_with_next_page.freezed.dart';
part 'org_clients_with_next_page.g.dart';

@freezed
class OrgClientWithNextPage with _$OrgClientWithNextPage {
  @JsonSerializable(explicitToJson: true)
  const factory OrgClientWithNextPage({
    @JsonKey(name: 'org_clients') required List<OrgClient> orgClients,
    @JsonKey(name: 'next_page_exist') required bool nextPageExist,
  }) = _OrgClientWithNextPage;

  factory OrgClientWithNextPage.fromJson(Map<String, dynamic> json) =>
      _$OrgClientWithNextPageFromJson(json);
}
